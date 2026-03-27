part of '../credentials_list_event.dart';

final class LoadUserDocument extends CredentialsListEvent {
  const LoadUserDocument();

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    try {
      final document = await bloc.userSessionRepository.getUserDocument();
      emit(bloc.state.copyWith(userDocument: () => document));
    } catch (_) {
      // Silently fail — document display is non-critical
    }
  }
}
