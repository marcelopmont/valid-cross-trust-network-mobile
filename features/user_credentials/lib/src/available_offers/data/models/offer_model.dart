import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../domain/entities/offer_entity.dart';

class OfferModel {
  OfferModel({
    required this.credentialType,
    required this.schemaId,
    required this.schemaVersion,
    required this.issuer,
    this.preview = const {},
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    final issuerJson = json['issuer'] as Map<String, dynamic>;
    return OfferModel(
      credentialType: json['credentialType'] as String,
      schemaId: json['schemaId'] as String,
      schemaVersion: json['schemaVersion'] as String,
      issuer: IssuerModel.fromJson(issuerJson),
      preview: json['preview'] as Map<String, dynamic>? ?? {},
    );
  }

  final String credentialType;
  final String schemaId;
  final String schemaVersion;
  final IssuerModel issuer;
  final Map<String, dynamic> preview;

  OfferEntity toEntity() => OfferEntity(
    credentialType: credentialType,
    schemaId: schemaId,
    schemaVersion: schemaVersion,
    issuer: issuer.toEntity(),
    preview: preview,
  );
}

class IssuerModel {
  IssuerModel({required this.did, required this.name});

  factory IssuerModel.fromJson(Map<String, dynamic> json) {
    return IssuerModel(
      did: json['did'] as String,
      name: json['name'] as String,
    );
  }

  final String did;
  final String name;

  IssuerEntity toEntity() => IssuerEntity(did: did, name: name);
}
