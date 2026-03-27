abstract class UserSessionRepository {
  Future<String?> getUserDocument();
  Future<void> logout();
}
