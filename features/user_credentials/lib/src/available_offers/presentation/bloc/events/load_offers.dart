part of '../available_offers_event.dart';

final class LoadOffers extends AvailableOffersEvent {
  const LoadOffers();

  @override
  Future<void> execute(
    AvailableOffersBloc bloc,
    Emitter<AvailableOffersState> emit,
  ) async {
    emit(bloc.state.copyWith(isLoading: true));

    try {
      final offers = await bloc.offersRepository.getAvailableOffers();
      emit(bloc.state.copyWith(isLoading: false, offers: offers));
    } catch (e) {
      emit(
        bloc.state.copyWith(
          isLoading: false,
          error: () => 'offersLoadError',
        ),
      );
    }
  }
}
