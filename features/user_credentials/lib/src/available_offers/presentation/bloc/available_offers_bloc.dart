import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/offers_repository.dart';
import 'available_offers_event.dart';
import 'available_offers_state.dart';

class AvailableOffersBloc
    extends Bloc<AvailableOffersEvent, AvailableOffersState> {
  AvailableOffersBloc({required this.offersRepository})
    : super(const AvailableOffersState()) {
    on<AvailableOffersEvent>((event, emit) => event.execute(this, emit));
  }

  final OffersRepository offersRepository;
}

class AvailableOffersBlocProvider extends BlocProvider<AvailableOffersBloc> {
  AvailableOffersBlocProvider({super.key, super.child})
    : super(
        create: (context) =>
            AvailableOffersBloc(offersRepository: di<OffersRepository>())
              ..add(const LoadOffers()),
      );

  static AvailableOffersBloc of(BuildContext context) =>
      BlocProvider.of<AvailableOffersBloc>(context);
}
