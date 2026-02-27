import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import 'splash_bloc.dart';
import 'splash_bloc_state.dart';

part 'events/check_authentication.dart';

@immutable
sealed class SplashBlocEvent extends Equatable {
  const SplashBlocEvent();

  Future<void> execute(SplashBloc bloc, Emitter<SplashBlocState> emit);

  @override
  List get props => [DateTime.now().toIso8601String()];
}
