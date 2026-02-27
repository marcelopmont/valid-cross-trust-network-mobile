import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import 'available_offers_bloc.dart';
import 'available_offers_state.dart';

part 'events/load_offers.dart';

@immutable
sealed class AvailableOffersEvent extends Equatable {
  const AvailableOffersEvent();

  Future<void> execute(
    AvailableOffersBloc bloc,
    Emitter<AvailableOffersState> emit,
  );

  @override
  List get props => [DateTime.now().toIso8601String()];
}
