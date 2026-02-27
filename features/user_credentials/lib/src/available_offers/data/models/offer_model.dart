import '../../domain/entities/offer_entity.dart';

class OfferModel {
  OfferModel({
    required this.credentialId,
    required this.number,
    required this.holderName,
    required this.documentType,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final attributesMap = _convertListToMap(attributes);
    return OfferModel(
      credentialId: json['offerId'] as String,
      number: attributesMap['registrationNumber'] as String,
      holderName: attributesMap['holderName'] as String,
      documentType: attributesMap['licenseType'] as String,
    );
  }

  final String credentialId;
  final String number;
  final String holderName;
  final String documentType;

  OfferEntity toEntity() => OfferEntity(
    credentialId: credentialId,
    number: number,
    holderName: holderName,
    documentType: documentType,
  );

  static Map<String, dynamic> _convertListToMap(List<dynamic> list) {
    final map = <String, dynamic>{};
    for (final item in list) {
      map[item['name'] as String] = item['value'];
    }
    return map;
  }
}
