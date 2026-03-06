part of '../signup_bloc_event.dart';

final class PerformSignup extends SignupBlocEvent {
  const PerformSignup({required this.cpf, required this.password});

  final String cpf;
  final String password;

  @override
  Future<void> execute(SignupBloc bloc, Emitter<SignupBlocState> emit) async {
    emit(bloc.state.copyWith(isLoading: true, error: () => null));

    try {
      await bloc.signupRepository.register(cpf: cpf, password: password);
      emit(bloc.state.copyWith(isLoading: false, isRegistered: true));
    } on SignupErrors catch (e) {
      emit(bloc.state.copyWith(isLoading: false, error: () => e));
    }
  }
}
