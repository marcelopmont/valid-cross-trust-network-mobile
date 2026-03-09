import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'presentation/bloc/signin_bloc.dart';
import 'presentation/containers/signin_container.dart';

class SigninRoute extends GoRoute {
  SigninRoute()
    : super(
        name: RouteNames.signin,
        path: '/signin',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: SigninBlocProvider(
              child: SigninContainer(
                onSigninSuccess: () {
                  context.goNamed(RouteNames.credentialsList);
                },
                onNavigateToSignup: () {
                  context.pushNamed(RouteNames.signup);
                },
              ),
            ),
          );
        },
      );
}
