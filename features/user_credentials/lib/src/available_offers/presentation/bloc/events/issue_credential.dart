part of '../available_offers_event.dart';

final class IssueCredential extends AvailableOffersEvent {
  const IssueCredential({required this.schemaId, required this.consentId});

  final String schemaId;
  final String consentId;

  @override
  Future<void> execute(
    AvailableOffersBloc bloc,
    Emitter<AvailableOffersState> emit,
  ) async {
    emit(bloc.state.copyWith(issuingSchemaId: schemaId, error: () => null));

    try {
      await bloc.offersRepository.issueCredential(
        schemaId: schemaId,
        consentId: consentId,
      );

      emit(
        bloc.state.copyWith(issuingSchemaId: null, isCredentialIssued: true),
      );
    } catch (e) {
      emit(
        bloc.state.copyWith(
          issuingSchemaId: null,
          error: () => 'Erro ao emitir credencial. Tente novamente.',
        ),
      );
    }
  }
}
