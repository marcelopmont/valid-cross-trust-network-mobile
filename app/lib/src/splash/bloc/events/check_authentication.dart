part of '../splash_bloc_event.dart';

final class CheckAuthentication extends SplashBlocEvent {
  const CheckAuthentication();

  @override
  Future<void> execute(SplashBloc bloc, Emitter<SplashBlocState> emit) async {
    try {
      final token = await bloc.splashRepository.getToken();

      emit(
        bloc.state.copyWith(
          isChecking: false,
          isLoggedIn: token != null && token.isNotEmpty,
        ),
      );
    } catch (e) {
      emit(bloc.state.copyWith(isChecking: false, isLoggedIn: false));
    }
  }
}
