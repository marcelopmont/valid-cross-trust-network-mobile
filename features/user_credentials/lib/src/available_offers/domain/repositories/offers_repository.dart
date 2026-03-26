import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../entities/offer_entity.dart';

abstract class OffersRepository {
  Future<List<OfferEntity>> getAvailableOffers();
  Future<VerifiableCredentialEntity> issueCredential({
    required String offerId,
    required String consentId,
  });
}
