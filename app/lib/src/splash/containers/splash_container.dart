import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../bloc/splash_bloc.dart';
import '../bloc/splash_bloc_state.dart';
import '../widgets/splash_screen.dart';

class SplashContainer extends BlocConsumer<SplashBloc, SplashBlocState> {
  SplashContainer({super.key})
    : super(
        listener: (context, state) {
          if (!state.isChecking) {
            if (state.isLoggedIn) {
              context.goNamed(RouteNames.consent);
            } else {
              context.goNamed(RouteNames.signin);
            }
          }
        },
        builder: (context, state) {
          return const SplashScreen();
        },
      );
}
