import 'package:dependencies/dependencies.dart';

import '../../domain/services/user_document_storage_service.dart';

class UserDocumentStorageServiceImpl implements UserDocumentStorageService {
  UserDocumentStorageServiceImpl({required this.storage});

  final FlutterSecureStorage storage;
  static const String _documentKey = 'user_document';

  @override
  Future<void> saveDocument(String document) async {
    await storage.write(key: _documentKey, value: document);
  }

  @override
  Future<String?> getDocument() async {
    return await storage.read(key: _documentKey);
  }

  @override
  Future<void> deleteDocument() async {
    await storage.delete(key: _documentKey);
  }
}
