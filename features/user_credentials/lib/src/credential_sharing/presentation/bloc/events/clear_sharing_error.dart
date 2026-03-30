part of '../credential_sharing_event.dart';

final class ClearSharingError extends CredentialSharingEvent {
  const ClearSharingError();

  @override
  Future<void> execute(
    CredentialSharingBloc bloc,
    Emitter<CredentialSharingState> emit,
  ) async {
    emit(bloc.state.copyWith(error: () => null));
  }
}
