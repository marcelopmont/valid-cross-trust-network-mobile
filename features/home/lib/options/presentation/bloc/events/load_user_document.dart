part of '../options_bloc_event.dart';

final class LoadUserDocument extends OptionsBlocEvent {
  const LoadUserDocument();

  @override
  Future<void> execute(OptionsBloc bloc, Emitter<OptionsBlocState> emit) async {
    try {
      final document = await bloc.optionsRepository.getUserDocument();
      emit(bloc.state.copyWith(isLoading: false, userDocument: () => document));
    } catch (e) {
      emit(bloc.state.copyWith(isLoading: false));
    }
  }
}
