import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:network/network.dart';

/// Concrete implementation of [SessionManager] that clears
/// session data and redirects the user to the sign-in screen
/// when a 401 Unauthorized response is received.
class SessionManagerImpl implements SessionManager {
  SessionManagerImpl({
    required this.tokenStorageService,
    required this.userDocumentStorageService,
    required this.router,
  });

  final TokenStorageService tokenStorageService;
  final UserDocumentStorageService userDocumentStorageService;
  final GoRouter router;

  @override
  Future<void> onSessionExpired() async {
    await tokenStorageService.deleteToken();
    await userDocumentStorageService.deleteDocument();
    router.goNamed(RouteNames.signin);
  }

  @override
  Future<bool> hasSession() async {
    final token = await tokenStorageService.getToken();
    return token != null && token.isNotEmpty;
  }
}
