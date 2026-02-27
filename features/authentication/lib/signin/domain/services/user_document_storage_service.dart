abstract class UserDocumentStorageService {
  Future<void> saveDocument(String document);
  Future<String?> getDocument();
  Future<void> deleteDocument();
}
