# Relatório de Implementação — Google Wallet (Credenciais Digitais)

## 1. Visão Geral da Arquitetura

O fluxo de adição de credencial à Google Wallet atravessa 4 camadas:

```
UI (Flutter) → BLoC → Repository (HTTP) → Backend VTN
                         ↓
              GoogleWalletService (MethodChannel)
                         ↓
              Android Nativo (Jetpack Credentials API)
```

---

## 2. Protocolo de Comunicação com o Backend

### Endpoint

|                  |                        |
| ---------------- | ---------------------- |
| **Método**       | `POST`                 |
| **Path**         | `/google-wallet/offer` |
| **Content-Type** | `application/json`     |

### Request

```json
{
  "credentialId": "<uuid>"
}
```

> O `credentialId` armazenado internamente no formato `urn:uuid:xxxx` é limpo para UUID puro (`xxxx`) antes do envio.

### Response

O backend retorna um JSON contendo um objeto `credentialOffer` com os campos utilizados pelo app:

```json
{
  "credentialOffer": {
    "protocol": "...",
    "credential_issuer": "...",
    "grants": { ... }
  }
}
```

---

## 3. Transformação de Dados (Flutter → Nativo)

O `GoogleWalletService` (`common/core/lib/src/services/google_wallet_service.dart`) recebe o JSON do backend e o reestrutura para o formato **W3C Digital Credentials `create()`**:

```json
{
  "requests": [
    {
      "protocol": "<credentialOffer.protocol>",
      "data": {
        "credential_issuer": "<credentialOffer.credential_issuer>",
        "grants": "<credentialOffer.grants>"
      }
    }
  ]
}
```

Este JSON reestruturado é enviado ao lado nativo via **MethodChannel**.

---

## 4. Comunicação Flutter ↔ Android Nativo

|               |                                                           |
| ------------- | --------------------------------------------------------- |
| **Canal**     | `com.valid.wallet/provisioning`                           |
| **Método**    | `addCredential`                                           |
| **Argumento** | `{ "offerJson": "<W3C formatted JSON>" }`                 |
| **Retorno**   | `bool` — `true` (sucesso) ou `false` (falha/cancelamento) |

### Implementação Android (`app/android/app/src/main/kotlin/com/valid/didapppoc/app/MainActivity.kt`)

- Usa **Jetpack Credentials API** (`androidx.credentials:credentials:1.6.0-rc02`)
- Cria um `CreateDigitalCredentialRequest` com o JSON W3C
- Chama `credentialManager.createCredential()` que abre a **UI do sistema** para o usuário confirmar
- Executa em `lifecycleScope` (coroutine)

### Dependências Android (`app/android/app/build.gradle.kts`)

```kotlin
implementation("androidx.credentials:credentials:1.6.0-rc02")
implementation("androidx.credentials:credentials-play-services-auth:1.6.0-rc02")
```

> Usa a annotation `@ExperimentalDigitalCredentialApi`.

---

## 5. Camada de Dados (Repository)

A interface `CredentialDetailRepository` define:

```dart
Future<String> getGoogleWalletOffer(String credentialId);
```

A implementação (`CredentialDetailRepositoryImpl`) usa `HttpClient` (baseado em **Dio**) para fazer o `POST /google-wallet/offer`.

---

## 6. Gerenciamento de Estado (BLoC)

| Componente | Arquivo                        |
| ---------- | ------------------------------ |
| **Bloc**   | `credential_detail_bloc.dart`  |
| **Event**  | `events/add_to_wallet.dart`    |
| **State**  | `credential_detail_state.dart` |

### Fluxo do evento `AddCredentialToWallet`:

1. Emite `isAddingToWallet: true`
2. Chama `credentialDetailRepository.getGoogleWalletOffer(credentialId)`
3. Valida que a resposta não está vazia
4. Chama `googleWalletService.addCredentialToWallet(offerJson)`
5. Se sucesso → `isAddingToWallet: false`
6. Se erro → `isAddingToWallet: false, error: unknownError`

### Injeção de Dependência (`user_credentials_service_locator.dart`):

- `GoogleWalletService` — registrado como **lazy singleton**
- `CredentialDetailRepository` — registrado como **factory**

---

## 7. Interface do Usuário

### Tela de Detalhe da Credencial (`credential_detail_screen.dart`)

- Botão "Adicionar à Carteira do Google" com ícone dedicado
- Visível **apenas quando a credencial não está revogada**
- Mostra loading spinner durante o processo

### Card na Lista (`credential_card.dart`)

- Imagem `add_to_google_wallet.png` no card
- **Apenas credenciais do tipo `AgeVerificationCredential`** são elegíveis para o botão na lista
- Funcionalidade na lista está **comentada/desabilitada** no container — ação foi movida para a tela de detalhe

---

## 8. Plataformas Suportadas

| Plataforma  | Status              | Observações                                                        |
| ----------- | ------------------- | ------------------------------------------------------------------ |
| **Android** | ✅ Implementado     | Jetpack Credentials API (`@ExperimentalDigitalCredentialApi`)      |
| **iOS**     | ❌ Não implementado | `AppDelegate.swift` só trata liveness; sem MethodChannel de wallet |

---

## 9. Formato de Dados — Resumo End-to-End

```
┌─────────────────────────────────────────────────────┐
│ 1. App → Backend                                    │
│    POST /google-wallet/offer                        │
│    Body: { "credentialId": "uuid-sem-prefixo" }     │
├─────────────────────────────────────────────────────┤
│ 2. Backend → App                                    │
│    Response JSON:                                   │
│    {                                                │
│      "credentialOffer": {                           │
│        "protocol": "...",                           │
│        "credential_issuer": "...",                  │
│        "grants": { ... }                            │
│      }                                              │
│    }                                                │
├─────────────────────────────────────────────────────┤
│ 3. App (Flutter) → App (Android nativo)             │
│    MethodChannel: com.valid.wallet/provisioning     │
│    Método: addCredential                            │
│    Payload (W3C Digital Credentials format):        │
│    {                                                │
│      "requests": [{                                 │
│        "protocol": "...",                           │
│        "data": {                                    │
│          "credential_issuer": "...",                │
│          "grants": { ... }                          │
│        }                                            │
│      }]                                             │
│    }                                                │
├─────────────────────────────────────────────────────┤
│ 4. Android → Google Wallet                          │
│    CreateDigitalCredentialRequest(requestJson)       │
│    credentialManager.createCredential()              │
│    → Abre UI nativa do sistema para confirmação     │
└─────────────────────────────────────────────────────┘
```

---

## 10. Pontos em Aberto / Para Discussão

1. **iOS** — sem implementação nativa (precisaria de PassKit ou equivalente)
2. **Feedback de sucesso** — após adicionar com sucesso, não há snackbar ou confirmação visual explícita (apenas remove o loading)
3. **Elegibilidade** — na lista, apenas `AgeVerificationCredential` é elegível; na tela de detalhe, **qualquer credencial não-revogada** pode ser adicionada — essa divergência pode ser intencional ou precisa de alinhamento
4. **Pacote `wallet`** — referenciado no `pubspec.yaml` do app mas não presente no workspace (possível uso futuro)
5. **API experimental** — uso de `@ExperimentalDigitalCredentialApi` na implementação Android indica que a Credentials API para Digital Credentials ainda não é estável no Jetpack
