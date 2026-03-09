import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'presentation/bloc/signup_bloc.dart';
import 'presentation/containers/signup_container.dart';

class SignupRoute extends GoRoute {
  SignupRoute()
    : super(
        name: RouteNames.signup,
        path: '/signup',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: SignupBlocProvider(
              child: SignupContainer(
                onSignupSuccess: () {
                  context.goNamed(RouteNames.consent);
                },
                onNavigateToSignin: () {
                  context.pop();
                },
              ),
            ),
          );
        },
      );
}
