part of '../credential_sharing_event.dart';

final class SubmitPresentation extends CredentialSharingEvent {
  const SubmitPresentation();

  @override
  Future<void> execute(
    CredentialSharingBloc bloc,
    Emitter<CredentialSharingState> emit,
  ) async {
    final request = bloc.state.verifierRequest;
    final credential = bloc.state.selectedCredential;
    if (request == null || credential == null) return;

    emit(bloc.state.copyWith(isSubmitting: true, error: () => null));

    try {
      final result = await bloc.credentialSharingRepository.createPresentation(
        verifierDid: request.verifierDid,
        credentials: [
          (
            credentialId: credential.credentialId.replaceFirst('urn:uuid:', ''),
            fields: request.requestedFields,
          ),
        ],
        challenge: request.challenge,
        domain: request.verifierDid,
      );

      emit(bloc.state.copyWith(isSubmitting: false, result: () => result));
    } on CredentialSharingErrors catch (e) {
      emit(bloc.state.copyWith(isSubmitting: false, error: () => e));
    } catch (_) {
      emit(
        bloc.state.copyWith(
          isSubmitting: false,
          error: () => CredentialSharingErrors.unknownError,
        ),
      );
    }
  }
}
