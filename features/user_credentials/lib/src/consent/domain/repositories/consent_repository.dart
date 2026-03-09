import '../entities/consent.dart';

abstract class ConsentRepository {
  Future<List<Consent>> getConsents();
  Future<Consent> grantConsent();
}
