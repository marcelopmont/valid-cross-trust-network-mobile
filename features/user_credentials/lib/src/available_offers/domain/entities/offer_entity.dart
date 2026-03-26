import 'package:dependencies/dependencies.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';

class OfferEntity extends Equatable {
  const OfferEntity({
    required this.id,
    required this.credentialType,
    required this.schemaId,
    required this.schemaVersion,
    required this.issuer,
    this.preview = const {},
  });

  final String id;
  final String credentialType;
  final String schemaId;
  final String schemaVersion;
  final IssuerEntity issuer;
  final Map<String, dynamic> preview;

  @override
  List<Object?> get props => [
    id,
    credentialType,
    schemaId,
    schemaVersion,
    issuer,
    preview,
  ];
}
