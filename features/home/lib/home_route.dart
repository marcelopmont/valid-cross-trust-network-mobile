import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:user_credentials/user_credentials.dart';

import 'options/presentation/bloc/options_bloc.dart';
import 'options/presentation/containers/options_container.dart';
import 'root/screens/root_screen.dart';
import 'scanner/screens/qr_scanner_screen.dart';

class HomeRoute extends StatefulShellRoute {
  HomeRoute()
    : super(
        builder: (context, state, navigationShell) {
          return RootScreen(navigationShell: navigationShell);
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return IndexedStack(
            index: navigationShell.currentIndex,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(routes: [UserCredentialsRoute()]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.scan,
                path: '/scan',
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: Material(child: QrScannerScreen()),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.options,
                path: '/options',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: OptionsBlocProvider(child: OptionsContainer()),
                  );
                },
              ),
            ],
          ),
        ],
      );
}
