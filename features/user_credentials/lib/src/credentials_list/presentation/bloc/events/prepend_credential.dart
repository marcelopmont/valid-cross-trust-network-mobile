part of '../credentials_list_event.dart';

final class PrependCredential extends CredentialsListEvent {
  const PrependCredential({required this.credential});

  final VerifiableCredentialEntity credential;

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    emit(
      bloc.state.copyWith(
        credentials: [credential, ...bloc.state.credentials],
      ),
    );
  }
}
