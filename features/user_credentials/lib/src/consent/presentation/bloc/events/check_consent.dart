part of '../consent_bloc_event.dart';

final class CheckConsent extends ConsentBlocEvent {
  const CheckConsent();

  @override
  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit) async {
    emit(bloc.state.copyWith(isCheckingConsent: true));

    try {
      final consents = await bloc.consentRepository.getConsents(
        schemaId: bloc.schemaId,
      );
      final activeConsent = consents
          .where((c) => c.status == 'active')
          .firstOrNull;

      emit(
        bloc.state.copyWith(
          isCheckingConsent: false,
          hasActiveConsent: activeConsent != null,
          generatedConsentId: activeConsent?.consentId,
        ),
      );
    } on ConsentErrors catch (e) {
      emit(bloc.state.copyWith(isCheckingConsent: false, error: () => e));
    }
  }
}
