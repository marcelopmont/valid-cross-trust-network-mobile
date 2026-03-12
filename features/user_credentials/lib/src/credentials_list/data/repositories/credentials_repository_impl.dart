import 'dart:convert';

import 'package:network/network.dart';

import '../../domain/entities/verifiable_credential_entity.dart';
import '../../domain/errors/credentials_errors.dart';
import '../../domain/repositories/credentials_repository.dart';
import '../models/credential_model.dart';

class CredentialsRepositoryImpl implements CredentialsRepository {
  CredentialsRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  static const int _limit = 10;

  @override
  Future<({List<VerifiableCredentialEntity> credentials, int total})>
  getCredentials({required int offset}) async {
    try {
      final response = await httpClient.get(
        HttpRequest(
          path: '/wallet/credentials',
          queryParameters: {'offset': offset, 'limit': _limit},
        ),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
      final credentials = (data['credentials'] as List)
          .map(
            (e) =>
                CredentialModel.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList();
      final total = data['total'] as int;

      return (credentials: credentials, total: total);
    } on HttpErrorResponse {
      throw CredentialsErrors.networkError;
    } catch (e) {
      if (e is CredentialsErrors) rethrow;
      throw CredentialsErrors.unknownError;
    }
  }

  @override
  Future<String> getGoogleWalletOffer(String credentialId) async {
    final uuid = credentialId.replaceFirst('urn:uuid:', '');
    try {
      final response = await httpClient.post(
        HttpRequest(
          path: '/google-wallet/offer',
          payload: jsonEncode({'credentialId': uuid}),
        ),
      );
      return response.dataJson ?? '';
    } on HttpErrorResponse {
      throw CredentialsErrors.networkError;
    } catch (e) {
      if (e is CredentialsErrors) rethrow;
      throw CredentialsErrors.unknownError;
    }
  }
}
