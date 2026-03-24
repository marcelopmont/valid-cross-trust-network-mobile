import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';

class IssuedCredentialModel {
  IssuedCredentialModel({
    required this.credentialId,
    required this.status,
    required this.issuedAt,
    required this.credentialType,
    this.expiresAt,
    this.preview = const {},
  });

  factory IssuedCredentialModel.fromJson(Map<String, dynamic> json) {
    return IssuedCredentialModel(
      credentialId: json['credentialId'] as String,
      status: json['status'] as String,
      issuedAt: json['issuedAt'] as String,
      credentialType: json['credentialType'] as String,
      expiresAt: json['expiresAt'] as String?,
      preview: json['preview'] as Map<String, dynamic>? ?? {},
    );
  }

  final String credentialId;
  final String status;
  final String issuedAt;
  final String credentialType;
  final String? expiresAt;
  final Map<String, dynamic> preview;

  VerifiableCredentialEntity toEntity() => VerifiableCredentialEntity(
    credentialId: credentialId,
    credentialType: credentialType,
    schemaVersion: '',
    issuer: const IssuerEntity(did: '', name: ''),
    issuedAt: issuedAt,
    expiresAt: expiresAt,
    status: status,
    preview: preview,
  );
}
