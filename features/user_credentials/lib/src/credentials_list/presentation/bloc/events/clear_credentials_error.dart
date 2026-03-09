part of '../credentials_list_event.dart';

final class ClearCredentialsError extends CredentialsListEvent {
  const ClearCredentialsError();

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    emit(bloc.state.copyWith(error: () => null));
  }
}
