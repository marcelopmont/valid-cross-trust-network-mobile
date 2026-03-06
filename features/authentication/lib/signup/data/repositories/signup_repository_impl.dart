import 'package:network/network.dart';

import '../../domain/errors/signup_errors.dart';
import '../../domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  SignupRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<void> register({
    required String cpf,
    required String password,
  }) async {
    try {
      await httpClient.post(
        HttpRequest(
          path: '/auth/register',
          payload: {'cpf': cpf, 'password': password},
        ),
      );
    } on HttpErrorResponse catch (e) {
      if (e.statusCode == 409) {
        throw SignupErrors.userAlreadyExists;
      }
      throw SignupErrors.networkError;
    } catch (e) {
      if (e is SignupErrors) rethrow;
      throw SignupErrors.unknownError;
    }
  }
}
