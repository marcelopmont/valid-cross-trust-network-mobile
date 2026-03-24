part of '../credential_detail_event.dart';

class RevokeCredential extends CredentialDetailEvent {
  const RevokeCredential();

  @override
  Future<void> execute(
    CredentialDetailBloc bloc,
    Emitter<CredentialDetailState> emit,
  ) async {
    emit(bloc.state.copyWith(isRevoking: true));
    try {
      await bloc.credentialDetailRepository.revokeCredential(
        credentialId: bloc.state.credential.credentialId,
        reason: 'Credential revoked by user',
      );
      emit(
        bloc.state.copyWith(
          isRevoking: false,
          isRevoked: true,
          credential: VerifiableCredentialEntity(
            credentialId: bloc.state.credential.credentialId,
            credentialType: bloc.state.credential.credentialType,
            schemaVersion: bloc.state.credential.schemaVersion,
            issuer: bloc.state.credential.issuer,
            issuedAt: bloc.state.credential.issuedAt,
            expiresAt: bloc.state.credential.expiresAt,
            status: 'revoked',
            preview: bloc.state.credential.preview,
          ),
        ),
      );
    } on CredentialsErrors catch (e) {
      emit(
        bloc.state.copyWith(
          isRevoking: false,
          error: () => e,
        ),
      );
    }
  }
}
