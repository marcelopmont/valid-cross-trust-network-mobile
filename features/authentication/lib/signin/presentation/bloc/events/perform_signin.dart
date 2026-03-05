part of '../signin_bloc_event.dart';

final class PerformSignin extends SigninBlocEvent {
  const PerformSignin({required this.cpf, required this.password});

  final String cpf;
  final String password;

  @override
  Future<void> execute(SigninBloc bloc, Emitter<SigninBlocState> emit) async {
    emit(bloc.state.copyWith(isLoading: true, error: () => null));

    try {
      await bloc.signinRepository.login(cpf: cpf, password: password);
      emit(bloc.state.copyWith(isLoading: false, isAuthenticated: true));
    } on SigninErrors catch (e) {
      emit(bloc.state.copyWith(isLoading: false, error: () => e));
    }
  }
}
