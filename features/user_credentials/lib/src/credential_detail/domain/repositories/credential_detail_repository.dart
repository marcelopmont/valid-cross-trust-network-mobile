abstract class CredentialDetailRepository {
  Future<void> revokeCredential({
    required String credentialId,
    required String reason,
  });

  Future<String> getGoogleWalletOffer(String credentialId);
}
