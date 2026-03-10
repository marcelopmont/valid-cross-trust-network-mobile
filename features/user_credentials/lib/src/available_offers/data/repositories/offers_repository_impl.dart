import 'dart:convert';

import 'package:network/network.dart';

import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offers_repository.dart';
import '../models/offer_model.dart';

class OffersRepositoryImpl implements OffersRepository {
  OffersRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<List<OfferEntity>> getAvailableOffers() async {
    try {
      final response = await httpClient.get(
        const HttpRequest(path: '/credentials/offers'),
      );

      final data = jsonDecode(response.dataJson!) as Map<String, dynamic>;
      final offers = (data['offers'] as List)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();

      return offers;
    } on HttpErrorResponse {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Unknown error');
    }
  }

  @override
  Future<void> issueCredential({
    required String schemaId,
    required String consentId,
  }) async {
    try {
      await httpClient.post(
        HttpRequest(
          path: '/credentials/issue',
          payload: {'schemaId': schemaId, 'consentId': consentId},
        ),
      );
    } catch (e) {
      throw Exception('Failed to issue credential');
    }
  }
}
