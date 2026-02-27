part of '../liveness_verification_event.dart';

final class SetCredentialId extends LivenessVerificationEvent {
  const SetCredentialId({required this.credentialId});

  final String credentialId;

  @override
  Future<void> execute(
    LivenessVerificationBloc bloc,
    Emitter<LivenessVerificationState> emit,
  ) async {
    emit(bloc.state.copyWith(credentialId: credentialId));
  }

  @override
  List get props => [credentialId];
}
