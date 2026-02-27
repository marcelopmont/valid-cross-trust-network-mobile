import 'package:authentication/authentication.dart';

import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl({required this.userDocumentStorageService});

  final UserDocumentStorageService userDocumentStorageService;

  @override
  Future<String?> getUserDocument() async {
    return userDocumentStorageService.getDocument();
  }
}
