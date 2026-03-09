import 'package:authentication/authentication.dart';
import 'package:user_credentials/user_credentials.dart';

import '../../domain/repositories/options_repository.dart';

class OptionsRepositoryImpl implements OptionsRepository {
  OptionsRepositoryImpl({
    required this.tokenStorageService,
    required this.userDocumentStorageService,
    required this.credentialStorageService,
  });

  final TokenStorageService tokenStorageService;
  final UserDocumentStorageService userDocumentStorageService;
  final CredentialStorageService credentialStorageService;

  @override
  Future<String?> getUserDocument() async {
    return userDocumentStorageService.getDocument();
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      tokenStorageService.deleteToken(),
      userDocumentStorageService.deleteDocument(),
    ]);
  }
}
