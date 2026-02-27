part of '../options_bloc_event.dart';

final class PerformLogout extends OptionsBlocEvent {
  const PerformLogout();

  @override
  Future<void> execute(OptionsBloc bloc, Emitter<OptionsBlocState> emit) async {
    await bloc.optionsRepository.logout();
    emit(bloc.state.copyWith(isLoggedOut: true));
  }
}
