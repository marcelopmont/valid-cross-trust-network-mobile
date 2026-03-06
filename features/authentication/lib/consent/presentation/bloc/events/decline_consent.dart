part of '../consent_bloc_event.dart';

final class DeclineConsent extends ConsentBlocEvent {
  const DeclineConsent();

  @override
  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit) async {
    emit(bloc.state.copyWith(showDeclinedMessage: true));
  }
}
