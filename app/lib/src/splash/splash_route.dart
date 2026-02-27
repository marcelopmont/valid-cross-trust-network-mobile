import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'bloc/splash_bloc.dart';
import 'containers/splash_container.dart';

class SplashRoute extends GoRoute {
  SplashRoute()
    : super(
        name: RouteNames.splash,
        path: '/',
        builder: (context, state) {
          return SplashBlocProvider(child: SplashContainer());
        },
      );
}
