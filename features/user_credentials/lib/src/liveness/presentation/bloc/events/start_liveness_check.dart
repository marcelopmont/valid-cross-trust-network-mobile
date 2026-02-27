part of '../liveness_verification_event.dart';

final class StartLivenessCheck extends LivenessVerificationEvent {
  const StartLivenessCheck();

  @override
  Future<void> execute(
    LivenessVerificationBloc bloc,
    Emitter<LivenessVerificationState> emit,
  ) async {
    emit(bloc.state.copyWith(status: LivenessStatus.loading));

    try {
      final success = await bloc.livenessHubService.startLivenessCheck();

      if (success) {
        emit(
          bloc.state.copyWith(
            status: LivenessStatus.success,
            livenessCompleted: true,
            errorMessage: () => null,
          ),
        );
      } else {
        emit(
          bloc.state.copyWith(
            status: LivenessStatus.failure,
            errorMessage: () => 'Verificação de liveness não foi bem-sucedida',
          ),
        );
      }
    } catch (e) {
      emit(
        bloc.state.copyWith(
          status: LivenessStatus.failure,
          errorMessage: () =>
              '''Erro na verificação de liveness, por favor, tente novamente''',
        ),
      );
    }
  }
}
