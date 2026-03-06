part of '../consent_bloc_event.dart';

final class GrantConsent extends ConsentBlocEvent {
  const GrantConsent();

  @override
  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit) async {
    emit(bloc.state.copyWith(isGranting: true, error: () => null));

    try {
      await bloc.consentRepository.grantConsent();
      emit(bloc.state.copyWith(isGranting: false, isConsentGranted: true));
    } on ConsentErrors catch (e) {
      emit(bloc.state.copyWith(isGranting: false, error: () => e));
    }
  }
}
