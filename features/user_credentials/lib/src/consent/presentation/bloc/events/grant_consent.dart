part of '../consent_bloc_event.dart';

final class GrantConsent extends ConsentBlocEvent {
  const GrantConsent();

  @override
  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit) async {
    emit(bloc.state.copyWith(isGranting: true, error: () => null));

    try {
      final consent = await bloc.consentRepository.grantConsent(
        schemaId: bloc.schemaId,
      );

      emit(
        bloc.state.copyWith(
          isGranting: false,
          isConsentGranted: true,
          generatedConsentId: consent.consentId,
        ),
      );
    } on ConsentErrors catch (e) {
      emit(bloc.state.copyWith(isGranting: false, error: () => e));
    }
  }
}
