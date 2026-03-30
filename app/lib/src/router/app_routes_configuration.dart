import 'package:authentication/authentication.dart';
import 'package:dependencies/dependencies.dart';
import 'package:shell/shell.dart';

import '../splash/splash_route.dart';

abstract class AppRoutesConfiguration {
  AppRoutesConfiguration._();

  static List<RouteBase> routes() => <RouteBase>[
    SplashRoute(),
    SigninRoute(),
    SignupRoute(),
    AppShellRoute(),
  ];
}
