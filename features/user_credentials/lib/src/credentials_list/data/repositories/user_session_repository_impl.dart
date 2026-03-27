import 'package:authentication/authentication.dart';

import '../../domain/repositories/user_session_repository.dart';

class UserSessionRepositoryImpl implements UserSessionRepository {
  UserSessionRepositoryImpl({
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
