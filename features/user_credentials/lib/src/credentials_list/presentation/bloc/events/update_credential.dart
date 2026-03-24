part of '../credentials_list_event.dart';

class UpdateCredential extends CredentialsListEvent {
  const UpdateCredential({required this.credential});

  final VerifiableCredentialEntity credential;

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    final updatedList = bloc.state.credentials.map((c) {
      if (c.credentialId == credential.credentialId) {
        return credential;
      }
      return c;
    }).toList();

    emit(bloc.state.copyWith(credentials: updatedList));
  }
}
