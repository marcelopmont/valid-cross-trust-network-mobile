import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../domain/repositories/splash_repository.dart';
import 'splash_bloc_event.dart';
import 'splash_bloc_state.dart';

class SplashBloc extends Bloc<SplashBlocEvent, SplashBlocState> {
  SplashBloc({required this.splashRepository})
    : super(const SplashBlocState()) {
    on<SplashBlocEvent>((event, emit) => event.execute(this, emit));
  }

  final SplashRepository splashRepository;
}

class SplashBlocProvider extends BlocProvider<SplashBloc> {
  SplashBlocProvider({super.key, super.child})
    : super(
        create: (context) =>
            SplashBloc(splashRepository: di<SplashRepository>())
              ..add(const CheckAuthentication()),
      );

  static SplashBloc of(BuildContext context) =>
      BlocProvider.of<SplashBloc>(context);
}
