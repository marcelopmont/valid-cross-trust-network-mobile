import 'dart:convert';

import 'package:network/network.dart';

import '../../domain/entities/presentation_result_entity.dart';
import '../../domain/errors/credential_sharing_errors.dart';
import '../../domain/repositories/credential_sharing_repository.dart';
import '../models/presentation_result_model.dart';

class CredentialSharingRepositoryImpl implements CredentialSharingRepository {
  CredentialSharingRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<PresentationResultEntity> createPresentation({
    required String verifierDid,
    required List<({String credentialId, List<String> fields})> credentials,
    required String challenge,
    required String domain,
  }) async {
    try {
      final response = await httpClient.post(
        HttpRequest(
          path: '/presentations',
          payload: {
            'verifierDid': verifierDid,
            'credentials': credentials
                .map(
                  (c) => {'credentialId': c.credentialId, 'fields': c.fields},
                )
                .toList(),
            'challenge': challenge,
            'domain': domain,
            'delivery': 'didcomm',
          },
        ),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
      return PresentationResultModel.fromJson(data).toEntity();
    } on HttpErrorResponse {
      throw CredentialSharingErrors.networkError;
    } catch (e) {
      if (e is CredentialSharingErrors) rethrow;
      throw CredentialSharingErrors.unknownError;
    }
  }
}
