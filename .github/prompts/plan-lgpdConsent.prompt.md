# Plan: LGPD Consent Screen in Authentication Feature

## TL;DR

Add a consent gateway screen to the authentication flow. After login (and on app restart when already logged in), check if the user has an active LGPD consent via GET `/api/v1/consents`. If not, show a consent screen asking the user to agree to share name, CPF, birth date, and nationality. On acceptance, POST to `/api/v1/consents`. If the user declines, block them on the screen with a message that consent is mandatory. Also create a Dio auth interceptor to attach the Bearer token to authenticated requests.

---

## Phase 1: Auth Interceptor (Network Package)

**Why:** The consent endpoints require Bearer token auth, and the current `HttpClient`/Dio setup has no mechanism to attach tokens.

1. **Create `AuthInterceptor`** in `common/network/lib/src/http/auth_interceptor.dart`
   - Extends Dio's `Interceptor`
   - Constructor receives a `Future<String?> Function()` token provider (generic, no deps on auth package)
   - In `onRequest`, reads token via provider, adds `Authorization: Bearer <token>` header if token is non-null

2. **Export** `AuthInterceptor` from `common/network/lib/network.dart`

3. **Wire interceptor** in `app/lib/app_service_locator.dart`
   - After registering `TokenStorageService` and `Dio`, add `AuthInterceptor` to Dio instance using `di<TokenStorageService>().getToken` as the token provider
   - Update `network_service_locator.dart` to register Dio as a singleton (not factory) so the interceptor persists

---

## Phase 2: Domain Layer (Consent)

4. **Create entity** `features/authentication/lib/consent/domain/entities/consent.dart`
   - `Consent` class with `Equatable`: `consentId`, `status`, `credentialType`, `scope` (List<String>), `purpose`, `legalBasis`, `createdAt`, `revokedAt`, `revocationReason`

5. **Create errors** `features/authentication/lib/consent/domain/errors/consent_errors.dart`
   - `enum ConsentErrors { networkError, timeOut, unknownError }`

6. **Create repository interface** `features/authentication/lib/consent/domain/repositories/consent_repository.dart`
   - `Future<List<Consent>> getConsents()`
   - `Future<Consent> grantConsent()`

---

## Phase 3: Data Layer (Consent)

7. **Create repository impl** `features/authentication/lib/consent/data/repositories/consent_repository_impl.dart`
   - Depends on `HttpClient`
   - `getConsents()`: GET `/api/v1/consents` → parse `consents` list from response → return `List<Consent>`
   - `grantConsent()`: POST `/api/v1/consents` with body `{ credentialType: "CIN", scope: ["full_name", "cpf", "birth_date"], purpose: "Identity verification for account opening", legalBasis: "LGPD Art. 7, I - Consent" }` → parse response → return `Consent`
   - Map `HttpErrorResponse` to `ConsentErrors`

---

## Phase 4: Presentation Layer (Consent BLoC)

8. **Create state** `features/authentication/lib/consent/presentation/bloc/consent_bloc_state.dart`
   - Fields: `isCheckingConsent` (bool), `hasActiveConsent` (bool), `isGranting` (bool), `isConsentGranted` (bool), `error` (ConsentErrors?), `showDeclinedMessage` (bool)
   - `copyWith` with nullable trick for `error`

9. **Create event base** `features/authentication/lib/consent/presentation/bloc/consent_bloc_event.dart`
   - Sealed class `ConsentBlocEvent` with self-executing pattern
   - Parts: `check_consent.dart`, `grant_consent.dart`

10. **Create `CheckConsent` event** `features/authentication/lib/consent/presentation/bloc/events/check_consent.dart`
    - Calls `consentRepository.getConsents()`
    - If any consent has `status == "active"` → emit `hasActiveConsent: true`
    - Otherwise → emit `hasActiveConsent: false, isCheckingConsent: false`

11. **Create `GrantConsent` event** `features/authentication/lib/consent/presentation/bloc/events/grant_consent.dart`
    - Emits `isGranting: true`
    - Calls `consentRepository.grantConsent()`
    - On success → emit `isConsentGranted: true`
    - On error → emit error

12. **Create BLoC** `features/authentication/lib/consent/presentation/bloc/consent_bloc.dart`
    - Receives `ConsentRepository`
    - Single generic handler: `on<ConsentBlocEvent>((e, emit) => e.execute(this, emit))`
    - `ConsentBlocProvider` dispatches `CheckConsent` on creation

---

## Phase 5: UI Layer (Container + Screen)

13. **Create container** `features/authentication/lib/consent/presentation/containers/consent_container.dart`
    - `BlocConsumer<ConsentBloc, ConsentBlocState>`
    - **listener:**
      - If `hasActiveConsent` or `isConsentGranted` → `context.goNamed(RouteNames.credentialsList)`
    - **builder:**
      - If `isCheckingConsent` → loading indicator
      - Otherwise → `ConsentScreen` with `isGranting`, `showDeclinedMessage`, `onAccept`, `onDecline` callbacks

14. **Create screen** `features/authentication/lib/consent/presentation/screens/consent_screen.dart`
    - Pure stateless widget
    - Shows LGPD consent info: list of data to be shared (Nome completo, CPF, Data de nascimento, Nacionalidade)
    - Explains purpose: identity verification
    - Legal basis: LGPD Art. 7, I
    - "Aceitar" button → calls `onAccept`
    - "Recusar" button → calls `onDecline` (shows inline message that consent is mandatory)
    - Loading state during grant request

---

## Phase 6: Navigation & Wiring

15. **Add route name** in `common/core/lib/src/navigation/route_names.dart`
    - `static const String consent = 'Consent';`

16. **Create route** `features/authentication/lib/consent/consent_route.dart`
    - `ConsentRoute extends GoRoute` with path `/consent`
    - Wraps `ConsentBlocProvider → ConsentContainer`

17. **Update exports** in `features/authentication/lib/authentication.dart`
    - Export `consent/consent_route.dart`

18. **Register DI** in `features/authentication/lib/authentication_service_locator.dart`
    - Register `ConsentRepository` → `ConsentRepositoryImpl(httpClient: di<HttpClient>())`

19. **Add route** to `app/lib/src/router/app_routes_configuration.dart`
    - Add `ConsentRoute()` to the routes list

20. **Update signin navigation** in `features/authentication/lib/signin/signin_route.dart`
    - Change `onSigninSuccess` from `context.goNamed(RouteNames.credentialsList)` → `context.goNamed(RouteNames.consent)`

21. **Update splash navigation** in `app/lib/src/splash/containers/splash_container.dart`
    - Change `isLoggedIn` target from `context.goNamed(RouteNames.credentialsList)` → `context.goNamed(RouteNames.consent)`

---

## Relevant Files

**Create:**

- `common/network/lib/src/http/auth_interceptor.dart` — Dio interceptor, generic token provider function
- `features/authentication/lib/consent/domain/entities/consent.dart` — Entity with Equatable
- `features/authentication/lib/consent/domain/errors/consent_errors.dart` — Error enum
- `features/authentication/lib/consent/domain/repositories/consent_repository.dart` — Abstract repository
- `features/authentication/lib/consent/data/repositories/consent_repository_impl.dart` — HTTP impl, maps errors
- `features/authentication/lib/consent/presentation/bloc/consent_bloc.dart` — BLoC + BlocProvider
- `features/authentication/lib/consent/presentation/bloc/consent_bloc_event.dart` — Sealed event base
- `features/authentication/lib/consent/presentation/bloc/consent_bloc_state.dart` — State with copyWith
- `features/authentication/lib/consent/presentation/bloc/events/check_consent.dart` — GET consents event
- `features/authentication/lib/consent/presentation/bloc/events/grant_consent.dart` — POST consent event
- `features/authentication/lib/consent/presentation/containers/consent_container.dart` — BlocConsumer bridge
- `features/authentication/lib/consent/presentation/screens/consent_screen.dart` — Pure UI
- `features/authentication/lib/consent/consent_route.dart` — GoRoute

**Modify:**

- `common/network/lib/network.dart` — Export AuthInterceptor
- `common/network/lib/network_service_locator.dart` — Change Dio registration to singleton
- `app/lib/app_service_locator.dart` — Wire AuthInterceptor with token provider
- `common/core/lib/src/navigation/route_names.dart` — Add `consent` route name
- `features/authentication/lib/authentication.dart` — Export consent route
- `features/authentication/lib/authentication_service_locator.dart` — Register ConsentRepository
- `app/lib/src/router/app_routes_configuration.dart` — Add ConsentRoute
- `features/authentication/lib/signin/signin_route.dart` — Change navigation to consent
- `app/lib/src/splash/containers/splash_container.dart` — Change navigation to consent

---

## Verification

1. `fvm flutter analyze .` from root — no lint errors
2. Manual: Login with valid credentials → lands on consent screen (not credentialsList)
3. Manual: Accept consent → navigates to credentialsList
4. Manual: Decline consent → stays on screen with "consent is mandatory" message
5. Manual: Close and reopen app (already logged in, consent given) → skips consent screen, goes to credentialsList
6. Manual: Close and reopen app (already logged in, NO consent) → shows consent screen
7. Verify auth interceptor: check network logs to see `Authorization: Bearer ...` header on consent requests

---

## Decisions

- **Endpoint:** `/api/v1/consents` (not the doubled `/api/v1/api/v1/consents`)
- **Decline behavior:** User stays on consent screen with a message that consent is mandatory to continue. He can do a logout in this screen if he wants to login with another account.
- **Auth token:** Dio auth interceptor with generic token provider (no circular deps between network and auth)
- **Consent as gateway:** Both signin and splash route through consent check before reaching credentialsList
- **Scope:** Only consent feature; no L10n files (matching existing features which don't use L10n yet)
