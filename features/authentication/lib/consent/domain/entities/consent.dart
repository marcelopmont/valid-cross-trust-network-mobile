import 'package:dependencies/dependencies.dart';

class Consent extends Equatable {
  const Consent({
    required this.consentId,
    required this.status,
    required this.credentialType,
    required this.scope,
    required this.purpose,
    required this.legalBasis,
    required this.createdAt,
    this.revokedAt,
    this.revocationReason,
  });

  final String consentId;
  final String status;
  final String credentialType;
  final List<String> scope;
  final String purpose;
  final String legalBasis;
  final String createdAt;
  final String? revokedAt;
  final String? revocationReason;

  @override
  List<Object?> get props => [
    consentId,
    status,
    credentialType,
    scope,
    purpose,
    legalBasis,
    createdAt,
    revokedAt,
    revocationReason,
  ];
}
