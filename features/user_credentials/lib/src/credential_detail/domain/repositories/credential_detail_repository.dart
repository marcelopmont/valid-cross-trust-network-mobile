abstract class CredentialDetailRepository {
  Future<void> revokeCredential({
    required String credentialId,
    required String reason,
  });
}
