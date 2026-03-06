import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'presentation/bloc/consent_bloc.dart';
import 'presentation/containers/consent_container.dart';

class ConsentRoute extends GoRoute {
  ConsentRoute()
    : super(
        name: RouteNames.consent,
        path: '/consent',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: ConsentBlocProvider(
              child: ConsentContainer(
                onConsentGranted: () {
                  context.goNamed(RouteNames.credentialsList);
                },
                onLogout: () {
                  context.goNamed(RouteNames.signin);
                },
              ),
            ),
          );
        },
      );
}
