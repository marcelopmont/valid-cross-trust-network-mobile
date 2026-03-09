part of '../consent_bloc_event.dart';

final class PerformLogout extends ConsentBlocEvent {
  const PerformLogout();

  @override
  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit) async {
    await Future.wait([
      bloc.tokenStorageService.deleteToken(),
      bloc.userDocumentStorageService.deleteDocument(),
    ]);
    emit(bloc.state.copyWith(isLoggedOut: true));
  }
}
