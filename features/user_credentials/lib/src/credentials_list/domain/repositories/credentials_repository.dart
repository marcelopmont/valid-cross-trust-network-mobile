import '../entities/verifiable_credential_entity.dart';

abstract class CredentialsRepository {
  Future<({List<VerifiableCredentialEntity> credentials, int total})>
  getCredentials({required int offset});

  Future<String> getGoogleWalletOffer(String credentialId);
}
