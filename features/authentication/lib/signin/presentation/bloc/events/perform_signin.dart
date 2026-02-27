part of '../signin_bloc_event.dart';

final class PerformSignin extends SigninBlocEvent {
  const PerformSignin(this.document);

  final String document;

  @override
  Future<void> execute(SigninBloc bloc, Emitter<SigninBlocState> emit) async {
    emit(bloc.state.copyWith(error: () => null));

    try {
      if (document.isEmpty) {
        emit(bloc.state.copyWith(error: () => 'Please enter a document'));
        return;
      }

      await bloc.signinRepository.saveDocument(document);
      emit(bloc.state.copyWith(isAuthenticated: true));
    } catch (e) {
      emit(bloc.state.copyWith(error: e.toString));
    }
  }
}
