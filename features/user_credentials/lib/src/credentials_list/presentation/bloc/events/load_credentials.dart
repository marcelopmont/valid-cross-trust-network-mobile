part of '../credentials_list_event.dart';

final class LoadCredentials extends CredentialsListEvent {
  const LoadCredentials();

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    if (bloc.state.isLoading || bloc.state.hasReachedEnd) return;

    emit(bloc.state.copyWith(isLoading: true, error: () => null));

    try {
      final result = await bloc.credentialsRepository.getCredentials(
        offset: bloc.state.offset,
      );

      final updatedCredentials = [
        ...bloc.state.credentials,
        ...result.credentials,
      ];

      final newOffset = bloc.state.offset + result.credentials.length;
      final hasReachedEnd = newOffset >= result.total;

      emit(
        bloc.state.copyWith(
          credentials: updatedCredentials,
          isLoading: false,
          total: result.total,
          offset: newOffset,
          hasReachedEnd: hasReachedEnd,
        ),
      );
    } on CredentialsErrors catch (e) {
      emit(bloc.state.copyWith(isLoading: false, error: () => e));
    }
  }
}
