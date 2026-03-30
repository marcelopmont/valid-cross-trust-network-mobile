import 'dart:convert';

import 'package:network/network.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offers_repository.dart';
import '../models/issued_credential_model.dart';
import '../models/offer_model.dart';

class OffersRepositoryImpl implements OffersRepository {
  OffersRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  static const _maxRetries = 5;
  static const _retryDelay = Duration(seconds: 2);

  @override
  Future<List<OfferEntity>> getAvailableOffers() async {
    var attempt = 0;
    while (true) {
      try {
        final response = await httpClient.get(
          const HttpRequest(path: '/credentials/offers'),
        );

        final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
        final offers = (data['offers'] as List)
            .map(
              (e) => OfferModel.fromJson(e as Map<String, dynamic>).toEntity(),
            )
            .toList();

        return offers;
      } on HttpErrorResponse catch (e) {
        if (e.isTimeout && attempt < _maxRetries) {
          attempt++;
          await Future.delayed(_retryDelay);
          continue;
        }
        throw Exception('Network error');
      } catch (e) {
        throw Exception('Unknown error');
      }
    }
  }

  @override
  Future<VerifiableCredentialEntity> issueCredential({
    required String offerId,
    required String consentId,
  }) async {
    try {
      final response = await httpClient.post(
        HttpRequest(
          path: '/credentials/issue',
          payload: {'offerId': offerId, 'consentId': consentId},
        ),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
      return IssuedCredentialModel.fromJson(data).toEntity();
    } catch (e) {
      throw Exception('Failed to issue credential');
    }
  }
}
