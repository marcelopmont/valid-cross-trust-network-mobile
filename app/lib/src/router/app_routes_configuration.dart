import 'package:authentication/authentication.dart';
import 'package:dependencies/dependencies.dart';
import 'package:home/home.dart';
import 'package:user_credentials/user_credentials.dart';

import '../splash/splash_route.dart';

abstract class AppRoutesConfiguration {
  AppRoutesConfiguration._();

  static List<RouteBase> routes() => <RouteBase>[
    SplashRoute(),
    SigninRoute(),
    SignupRoute(),
    ConsentRoute(),
    HomeRoute(),
  ];
}
