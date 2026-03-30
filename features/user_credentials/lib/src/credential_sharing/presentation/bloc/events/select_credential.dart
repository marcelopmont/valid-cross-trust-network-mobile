part of '../credential_sharing_event.dart';

final class SelectCredential extends CredentialSharingEvent {
  const SelectCredential({required this.credential});

  final VerifiableCredentialEntity credential;

  @override
  Future<void> execute(
    CredentialSharingBloc bloc,
    Emitter<CredentialSharingState> emit,
  ) async {
    emit(bloc.state.copyWith(selectedCredential: () => credential));
  }
}
