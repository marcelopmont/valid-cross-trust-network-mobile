import '../entities/consent.dart';

abstract class ConsentRepository {
  Future<List<Consent>> getConsents({required String schemaId});
  Future<Consent> grantConsent({required String schemaId});
}
