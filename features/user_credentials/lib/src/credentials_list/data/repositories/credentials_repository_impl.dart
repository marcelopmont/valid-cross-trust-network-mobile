import '../../domain/repositories/credentials_repository.dart';
import '../../domain/services/credential_storage_service.dart';

class CredentialsRepositoryImpl implements CredentialsRepository {
  CredentialsRepositoryImpl({required this.credentialStorageService});

  final CredentialStorageService credentialStorageService;
}
