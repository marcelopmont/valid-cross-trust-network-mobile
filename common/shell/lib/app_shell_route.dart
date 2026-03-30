import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:user_credentials/user_credentials.dart';

import 'root_screen.dart';

class AppShellRoute extends StatefulShellRoute {
  AppShellRoute()
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
          StatefulShellBranch(routes: [QrScannerRoute()]),
        ],
      );
}
