import '../entities/offer_entity.dart';

abstract class OffersRepository {
  Future<List<OfferEntity>> getAvailableOffers();
}
