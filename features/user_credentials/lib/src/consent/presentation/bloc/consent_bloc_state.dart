import 'package:dependencies/dependencies.dart';

import '../../domain/errors/consent_errors.dart';

final class ConsentBlocState extends Equatable {
  const ConsentBlocState({
    this.isCheckingConsent = true,
    this.hasActiveConsent = false,
    this.isGranting = false,
    this.isConsentGranted = false,
    this.showDeclinedMessage = false,
    this.generatedConsentId,
    this.error,
  });

  final bool isCheckingConsent;
  final bool hasActiveConsent;
  final bool isGranting;
  final bool isConsentGranted;
  final bool showDeclinedMessage;
  final String? generatedConsentId;
  final ConsentErrors? error;

  ConsentBlocState copyWith({
    bool? isCheckingConsent,
    bool? hasActiveConsent,
    bool? isGranting,
    bool? isConsentGranted,
    bool? showDeclinedMessage,
    String? generatedConsentId,
    ConsentErrors? Function()? error,
  }) {
    return ConsentBlocState(
      isCheckingConsent: isCheckingConsent ?? this.isCheckingConsent,
      hasActiveConsent: hasActiveConsent ?? this.hasActiveConsent,
      isGranting: isGranting ?? this.isGranting,
      isConsentGranted: isConsentGranted ?? this.isConsentGranted,
      showDeclinedMessage: showDeclinedMessage ?? this.showDeclinedMessage,
      generatedConsentId: generatedConsentId ?? this.generatedConsentId,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
    isCheckingConsent,
    hasActiveConsent,
    isGranting,
    isConsentGranted,
    showDeclinedMessage,
    generatedConsentId,
    error,
  ];
}
