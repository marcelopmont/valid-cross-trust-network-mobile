import 'package:authentication/authentication.dart';

import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl({
    required this.userDocumentStorageService,
    required this.tokenStorageService,
  });

  final UserDocumentStorageService userDocumentStorageService;
  final TokenStorageService tokenStorageService;

  @override
  Future<String?> getUserDocument() async {
    return userDocumentStorageService.getDocument();
  }

  @override
  Future<String?> getToken() async {
    return tokenStorageService.getToken();
  }
}
