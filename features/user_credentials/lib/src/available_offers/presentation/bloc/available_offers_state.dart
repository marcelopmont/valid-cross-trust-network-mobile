import 'package:dependencies/dependencies.dart';

import '../../domain/entities/offer_entity.dart';

final class AvailableOffersState extends Equatable {
  const AvailableOffersState({
    this.isLoading = true,
    this.offers = const [],
    this.error,
    this.isCredentialIssued = false,
    this.issuingOfferId,
  });

  final bool isLoading;
  final List<OfferEntity> offers;
  final String? error;
  final bool isCredentialIssued;
  final String? issuingOfferId;

  AvailableOffersState copyWith({
    bool? isLoading,
    List<OfferEntity>? offers,
    String? Function()? error,
    bool? isCredentialIssued,
    String? Function()? issuingOfferId,
  }) {
    return AvailableOffersState(
      isLoading: isLoading ?? this.isLoading,
      offers: offers ?? this.offers,
      error: error != null ? error() : this.error,
      isCredentialIssued: isCredentialIssued ?? this.isCredentialIssued,
      issuingOfferId: issuingOfferId != null
          ? issuingOfferId()
          : this.issuingOfferId,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    offers,
    error,
    isCredentialIssued,
    issuingOfferId,
  ];
}
