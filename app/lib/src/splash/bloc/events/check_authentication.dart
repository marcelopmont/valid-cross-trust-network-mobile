part of '../splash_bloc_event.dart';

final class CheckAuthentication extends SplashBlocEvent {
  const CheckAuthentication();

  @override
  Future<void> execute(SplashBloc bloc, Emitter<SplashBlocState> emit) async {
    try {
      final document = await bloc.splashRepository.getUserDocument();

      emit(
        bloc.state.copyWith(
          isChecking: false,
          isLoggedIn: document != null && document.isNotEmpty,
        ),
      );
    } catch (e) {
      // If there's an error, assume not logged in
      emit(bloc.state.copyWith(isChecking: false, isLoggedIn: false));
    }
  }
}
