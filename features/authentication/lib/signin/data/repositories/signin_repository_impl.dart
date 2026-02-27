import '../../domain/errors/signin_errors.dart';
import '../../domain/repositories/signin_repository.dart';
import '../../domain/services/user_document_storage_service.dart';

class SigninRepositoryImpl implements SigninRepository {
  SigninRepositoryImpl({required this.userDocumentStorageService});

  final UserDocumentStorageService userDocumentStorageService;

  @override
  Future<void> saveDocument(String document) async {
    try {
      if (document.trim().isEmpty) {
        throw SigninErrors.invalidDocument;
      }

      await userDocumentStorageService.saveDocument(document);
    } catch (e) {
      if (e is SigninErrors) {
        rethrow;
      }
      throw SigninErrors.storageError;
    }
  }
}
