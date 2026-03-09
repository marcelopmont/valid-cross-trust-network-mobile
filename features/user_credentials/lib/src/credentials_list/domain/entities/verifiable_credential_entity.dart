import 'package:dependencies/dependencies.dart';

class VerifiableCredentialEntity extends Equatable {
  const VerifiableCredentialEntity({
    required this.credentialId,
    required this.credentialType,
    required this.schemaVersion,
    required this.issuer,
    required this.issuedAt,
    required this.status,
    this.expiresAt,
    this.preview = const {},
  });

  final String credentialId;
  final String credentialType;
  final String schemaVersion;
  final IssuerEntity issuer;
  final String issuedAt;
  final String? expiresAt;
  final String status;
  final Map<String, dynamic> preview;

  @override
  List<Object?> get props => [
    credentialId,
    credentialType,
    schemaVersion,
    issuer,
    issuedAt,
    expiresAt,
    status,
    preview,
  ];
}

class IssuerEntity extends Equatable {
  const IssuerEntity({required this.did, required this.name});

  final String did;
  final String name;

  @override
  List<Object?> get props => [did, name];
}
