import 'package:dependencies/dependencies.dart';

class VerifiableCredentialEntity extends Equatable {
  const VerifiableCredentialEntity({
    required this.id,
    required this.type,
    required this.issuer,
    required this.credentialSubject,
  });

  final String id;
  final List<String> type;
  final String issuer;
  final Map<String, dynamic> credentialSubject;

  @override
  List<Object?> get props => [id, type, issuer, credentialSubject];
}
