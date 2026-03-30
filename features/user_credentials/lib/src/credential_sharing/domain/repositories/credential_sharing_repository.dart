import '../entities/presentation_result_entity.dart';

abstract class CredentialSharingRepository {
  Future<PresentationResultEntity> createPresentation({
    required String verifierDid,
    required List<({String credentialId, List<String> fields})> credentials,
    required String challenge,
    required String domain,
  });
}
