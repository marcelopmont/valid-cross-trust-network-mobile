import 'dart:convert';

import 'package:network/network.dart';

import '../../domain/entities/consent.dart';
import '../../domain/errors/consent_errors.dart';
import '../../domain/repositories/consent_repository.dart';

class ConsentRepositoryImpl implements ConsentRepository {
  ConsentRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<List<Consent>> getConsents() async {
    try {
      final response = await httpClient.get(
        const HttpRequest(path: '/consents'),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
      final consents = (data['consents'] as List)
          .map(
            (e) => Consent(
              consentId: e['consentId'] as String,
              status: e['status'] as String,
              credentialType: e['credentialType'] as String,
              scope: List<String>.from(e['scope'] as List),
              purpose: e['purpose'] as String,
              legalBasis: e['legalBasis'] as String,
              createdAt: e['createdAt'] as String,
              revokedAt: e['revokedAt'] as String?,
              revocationReason: e['revocationReason'] as String?,
            ),
          )
          .toList();

      return consents;
    } on HttpErrorResponse {
      throw ConsentErrors.networkError;
    } catch (e) {
      if (e is ConsentErrors) rethrow;
      throw ConsentErrors.unknownError;
    }
  }

  @override
  Future<Consent> grantConsent() async {
    try {
      final response = await httpClient.post(
        const HttpRequest(
          path: '/consents',
          payload: {
            'credentialType': 'CIN',
            'scope': ['full_name', 'cpf', 'birth_date'],
            'purpose': 'Identity verification for account opening',
            'legalBasis': 'LGPD Art. 7, I - Consent',
          },
        ),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;

      return Consent(
        consentId: data['consentId'] as String,
        status: data['status'] as String,
        credentialType: data['credentialType'] as String,
        scope: List<String>.from(data['scope'] as List),
        purpose: data['purpose'] as String,
        legalBasis: data['legalBasis'] as String,
        createdAt: data['createdAt'] as String,
        revokedAt: data['revokedAt'] as String?,
        revocationReason: data['revocationReason'] as String?,
      );
    } on HttpErrorResponse {
      throw ConsentErrors.networkError;
    } catch (e) {
      if (e is ConsentErrors) rethrow;
      throw ConsentErrors.unknownError;
    }
  }
}
