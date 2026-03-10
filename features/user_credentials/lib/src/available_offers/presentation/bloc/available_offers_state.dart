import 'package:dependencies/dependencies.dart';

import '../../domain/entities/offer_entity.dart';

final class AvailableOffersState extends Equatable {
  const AvailableOffersState({
    this.isLoading = true,
    this.offers = const [],
    this.error,
    this.isCredentialIssued = false,
    this.issuingSchemaId,
  });

  final bool isLoading;
  final List<OfferEntity> offers;
  final String? error;
  final bool isCredentialIssued;
  final String? issuingSchemaId;

  AvailableOffersState copyWith({
    bool? isLoading,
    List<OfferEntity>? offers,
    String? Function()? error,
    bool? isCredentialIssued,
    String? issuingSchemaId,
  }) {
    return AvailableOffersState(
      isLoading: isLoading ?? this.isLoading,
      offers: offers ?? this.offers,
      error: error != null ? error() : this.error,
      isCredentialIssued: isCredentialIssued ?? this.isCredentialIssued,
      issuingSchemaId: issuingSchemaId ?? this.issuingSchemaId,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    offers,
    error,
    isCredentialIssued,
    issuingSchemaId,
  ];
}
