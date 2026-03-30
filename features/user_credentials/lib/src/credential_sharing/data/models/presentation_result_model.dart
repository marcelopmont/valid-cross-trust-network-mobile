import '../../domain/entities/presentation_result_entity.dart';

class PresentationResultModel {
  const PresentationResultModel({
    required this.presentationId,
    required this.delivery,
    required this.verifierDid,
    required this.credentialCount,
    required this.status,
  });

  factory PresentationResultModel.fromJson(Map<String, dynamic> json) {
    return PresentationResultModel(
      presentationId: json['presentationId'] as String,
      delivery: json['delivery'] as String,
      verifierDid: json['verifierDid'] as String,
      credentialCount: json['credentialCount'] as int,
      status: json['status'] as String,
    );
  }

  final String presentationId;
  final String delivery;
  final String verifierDid;
  final int credentialCount;
  final String status;

  PresentationResultEntity toEntity() {
    return PresentationResultEntity(
      presentationId: presentationId,
      delivery: delivery,
      verifierDid: verifierDid,
      credentialCount: credentialCount,
      status: status,
    );
  }
}
