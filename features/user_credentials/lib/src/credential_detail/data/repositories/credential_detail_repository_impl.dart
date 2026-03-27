import 'dart:convert';

import 'package:network/network.dart';

import '../../../credentials_list/domain/errors/credentials_errors.dart';
import '../../domain/repositories/credential_detail_repository.dart';

class CredentialDetailRepositoryImpl implements CredentialDetailRepository {
  CredentialDetailRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<void> revokeCredential({
    required String credentialId,
    required String reason,
  }) async {
    final uuid = credentialId.replaceFirst('urn:uuid:', '');
    try {
      await httpClient.post(
        HttpRequest(
          path: '/wallet/credentials/$uuid/revoke',
          payload: jsonEncode({'reason': reason}),
        ),
      );
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
