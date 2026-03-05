import 'package:dependencies/dependencies.dart';

import '../../domain/services/token_storage_service.dart';

class TokenStorageServiceImpl implements TokenStorageService {
  TokenStorageServiceImpl({required this.storage});

  final FlutterSecureStorage storage;
  static const String _tokenKey = 'access_token';

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return storage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: _tokenKey);
  }
}
