part of '../consent_bloc_event.dart';

final class CheckConsent extends ConsentBlocEvent {
  const CheckConsent();

  @override
  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit) async {
    emit(bloc.state.copyWith(isCheckingConsent: true));

    try {
      final consents = await bloc.consentRepository.getConsents();
      final hasActive = consents.any((c) => c.status == 'active');

      emit(
        bloc.state.copyWith(
          isCheckingConsent: false,
          hasActiveConsent: hasActive,
        ),
      );
    } on ConsentErrors catch (e) {
      emit(bloc.state.copyWith(isCheckingConsent: false, error: () => e));
    }
  }
}
