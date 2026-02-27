class OfferEntity {
  OfferEntity({
    required this.credentialId,
    required this.number,
    required this.holderName,
    required this.documentType,
  });

  final String credentialId;
  final String number;
  final String holderName;
  final String documentType;
}
