import '../entities/offer_entity.dart';

abstract class OffersRepository {
  Future<List<OfferEntity>> getAvailableOffers();
  Future<void> issueCredential({
    required String offerId,
    required String consentId,
  });
}
