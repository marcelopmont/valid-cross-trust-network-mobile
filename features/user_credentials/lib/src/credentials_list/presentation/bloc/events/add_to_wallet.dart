part of '../credentials_list_event.dart';

final class AddToWallet extends CredentialsListEvent {
  const AddToWallet({required this.credentialId});

  final String credentialId;

  @override
  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  ) async {
    emit(bloc.state.copyWith(issuingWalletCredentialId: credentialId));

    try {
      final offerJson = await bloc.credentialsRepository.getGoogleWalletOffer(
        credentialId,
      );

      if (offerJson.isNotEmpty) {
        final success = await bloc.googleWalletService.addCredentialToWallet(
          offerJson,
        );

        if (success) {
          // Em caso de sucesso, talvez mostrar um snackbar?
          // Dependendo da interface nativa, podemos apenas remover o
          // status de loading.
          emit(bloc.state.copyWith(issuingWalletCredentialId: null));
        } else {
          throw Exception('Google Wallet addition failed or was cancelled');
        }
      } else {
        throw Exception('Received an empty offer payload');
      }
    } catch (e) {
      emit(
        bloc.state.copyWith(
          issuingWalletCredentialId: null,
          error: () => CredentialsErrors.unknownError,
        ),
      );
    }
  }
}
