import 'dart:convert';

import 'package:dependencies/dependencies.dart' show sha256;
import 'package:network/network.dart';

import '../../../common/domain/services/token_storage_service.dart';
import '../../domain/errors/signin_errors.dart';
import '../../domain/repositories/signin_repository.dart';
import '../../domain/services/user_document_storage_service.dart';

class SigninRepositoryImpl implements SigninRepository {
  SigninRepositoryImpl({
    required this.httpClient,
    required this.tokenStorageService,
    required this.userDocumentStorageService,
  });

  final HttpClient httpClient;
  final TokenStorageService tokenStorageService;
  final UserDocumentStorageService userDocumentStorageService;

  @override
  Future<void> login({required String cpf, required String password}) async {
    try {
      final passwordHash = sha256.convert(utf8.encode(password)).toString();

      final response = await httpClient.post(
        HttpRequest(
          path: '/auth/login',
          payload: {'cpf': cpf, 'password': passwordHash},
        ),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
      final token = data['access_token'] as String;

      await tokenStorageService.saveToken(token);
      await userDocumentStorageService.saveDocument(cpf);
    } on HttpErrorResponse catch (e) {
      if (e.statusCode == 401) {
        throw SigninErrors.invalidCredentials;
      }
      throw SigninErrors.networkError;
    } catch (e) {
      if (e is SigninErrors) rethrow;
      throw SigninErrors.unknownError;
    }
  }
}
