import 'package:authentication/authentication.dart';
import 'package:authentication/authentication_service_locator.dart' as auth;
import 'package:core/core.dart';
import 'package:core/core_service_locator.dart' as core;
import 'package:dependencies/dependencies.dart';
import 'package:home/home_service_locator.dart' as home;
import 'package:network/network_service_locator.dart' as network;
import 'package:user_credentials/user_credentials_service_locator.dart'
    as user_credentials;

import 'src/splash/data/repositories/splash_repository_impl.dart';
import 'src/splash/domain/repositories/splash_repository.dart';

Future<void> initAppDependencies() async {
  await _serviceLocator();
  await core.initServiceLocator();
  await auth.initServiceLocator();
  await network.initServiceLocator();
  await user_credentials.initServiceLocator();
  await home.initServiceLocator();
  await _registerSplashDependencies();
}

Future<void> _serviceLocator() async {
  di.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  await di.allReady();
}

Future<void> _registerSplashDependencies() async {
  di.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      userDocumentStorageService: di<UserDocumentStorageService>(),
    ),
  );
}
