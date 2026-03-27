part of '../available_offers_event.dart';

final class IssueCredential extends AvailableOffersEvent {
  const IssueCredential({required this.offerId, required this.consentId});

  final String offerId;
  final String consentId;

  @override
  Future<void> execute(
    AvailableOffersBloc bloc,
    Emitter<AvailableOffersState> emit,
  ) async {
    emit(bloc.state.copyWith(issuingOfferId: () => offerId, error: () => null));

    try {
      final credential = await bloc.offersRepository.issueCredential(
        offerId: offerId,
        consentId: consentId,
      );

      emit(
        bloc.state.copyWith(
          issuingOfferId: () => null,
          issuedCredential: credential,
        ),
      );
    } catch (e) {
      emit(
        bloc.state.copyWith(
          issuingOfferId: () => null,
          error: () => 'credentialIssueError',
        ),
      );
    }
  }
}
