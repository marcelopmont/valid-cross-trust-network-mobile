part of '../credentials_list_event.dart';

final class PerformLogout extends CredentialsListEvent {
  const PerformLogout();

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    await bloc.userSessionRepository.logout();
    emit(bloc.state.copyWith(isLoggedOut: true));
  }
}
