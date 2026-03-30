import 'package:dependencies/dependencies.dart';

class VerifierRequestEntity extends Equatable {
  const VerifierRequestEntity({
    required this.verifierDid,
    required this.requestedFields,
    required this.purpose,
    required this.challenge,
  });

  final String verifierDid;
  final List<String> requestedFields;
  final String purpose;
  final String challenge;

  @override
  List<Object?> get props => [
    verifierDid,
    requestedFields,
    purpose,
    challenge,
  ];
}
