import 'package:dependencies/dependencies.dart';

class PresentationResultEntity extends Equatable {
  const PresentationResultEntity({
    required this.presentationId,
    required this.delivery,
    required this.verifierDid,
    required this.credentialCount,
    required this.status,
  });

  final String presentationId;
  final String delivery;
  final String verifierDid;
  final int credentialCount;
  final String status;

  @override
  List<Object?> get props => [
    presentationId,
    delivery,
    verifierDid,
    credentialCount,
    status,
  ];
}
