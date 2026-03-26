part of '../credential_detail_event.dart';

class AddCredentialToWallet extends CredentialDetailEvent {
  const AddCredentialToWallet();

  @override
  Future<void> execute(
    CredentialDetailBloc bloc,
    Emitter<CredentialDetailState> emit,
  ) async {
    emit(bloc.state.copyWith(isAddingToWallet: true, error: () => null));

    try {
      final offerJson = await bloc.credentialDetailRepository
          .getGoogleWalletOffer(bloc.state.credential.credentialId);

      if (offerJson.isEmpty) {
        throw Exception('Received an empty offer payload');
      }

      final success = await bloc.googleWalletService.addCredentialToWallet(
        offerJson,
      );

      if (!success) {
        throw Exception('Google Wallet addition failed or was cancelled');
      }

      emit(bloc.state.copyWith(isAddingToWallet: false));
    } catch (_) {
      emit(
        bloc.state.copyWith(
          isAddingToWallet: false,
          error: () => CredentialsErrors.unknownError,
        ),
      );
    }
  }
}
