part of '../credential_sharing_event.dart';

final class InitializeSharing extends CredentialSharingEvent {
  const InitializeSharing({required this.verifierRequest});

  final VerifierRequestEntity verifierRequest;

  @override
  Future<void> execute(
    CredentialSharingBloc bloc,
    Emitter<CredentialSharingState> emit,
  ) async {
    emit(bloc.state.copyWith(error: () => null));

    try {
      final result = await bloc.credentialsRepository.getCredentials(offset: 0);

      final matching = result.credentials
          .where((c) => c.status == 'active')
          .toList();

      emit(
        bloc.state.copyWith(
          verifierRequest: verifierRequest,
          matchingCredentials: matching,
          selectedCredential: () => matching.isNotEmpty ? matching.first : null,
        ),
      );
    } on CredentialSharingErrors catch (e) {
      emit(bloc.state.copyWith(error: () => e));
    } catch (_) {
      emit(
        bloc.state.copyWith(error: () => CredentialSharingErrors.unknownError),
      );
    }
  }
}
