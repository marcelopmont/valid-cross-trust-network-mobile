import '../../domain/entities/verifiable_credential_entity.dart';

class CredentialModel {
  CredentialModel({
    required this.credentialId,
    required this.credentialType,
    required this.schemaVersion,
    required this.issuer,
    required this.issuedAt,
    required this.status,
    this.expiresAt,
    this.preview = const {},
  });

  factory CredentialModel.fromJson(Map<String, dynamic> json) {
    final issuerJson = json['issuer'] as Map<String, dynamic>;
    return CredentialModel(
      credentialId: json['credentialId'] as String,
      credentialType: json['credentialType'] as String,
      schemaVersion: json['schemaVersion'] as String,
      issuer: IssuerModel.fromJson(issuerJson),
      issuedAt: json['issuedAt'] as String,
      expiresAt: json['expiresAt'] as String?,
      status: json['status'] as String,
      preview: json['preview'] as Map<String, dynamic>? ?? {},
    );
  }

  final String credentialId;
  final String credentialType;
  final String schemaVersion;
  final IssuerModel issuer;
  final String issuedAt;
  final String? expiresAt;
  final String status;
  final Map<String, dynamic> preview;

  VerifiableCredentialEntity toEntity() => VerifiableCredentialEntity(
    credentialId: credentialId,
    credentialType: credentialType,
    schemaVersion: schemaVersion,
    issuer: issuer.toEntity(),
    issuedAt: issuedAt,
    expiresAt: expiresAt,
    status: status,
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
