import 'package:authentication/authentication.dart';

import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offers_repository.dart';

class OffersRepositoryImpl implements OffersRepository {
  OffersRepositoryImpl({required this.userDocumentStorageService});

  final UserDocumentStorageService userDocumentStorageService;

  @override
  Future<List<OfferEntity>> getAvailableOffers() async {
    final userDocument = await userDocumentStorageService.getDocument();

    if (userDocument == null) {
      return [];
    }

    return [];
  }
}
