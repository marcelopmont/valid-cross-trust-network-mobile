import 'package:authentication/authentication.dart';

import '../../domain/repositories/options_repository.dart';

class OptionsRepositoryImpl implements OptionsRepository {
  OptionsRepositoryImpl({
    required this.tokenStorageService,
    required this.userDocumentStorageService,
  });

  final TokenStorageService tokenStorageService;
  final UserDocumentStorageService userDocumentStorageService;

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
