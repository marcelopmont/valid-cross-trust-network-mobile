import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:network/network.dart';

import 'authentication.dart';
import 'signin/data/repositories/signin_repository_impl.dart';
import 'signin/domain/repositories/signin_repository.dart';
import 'signup/data/repositories/signup_repository_impl.dart';
import 'signup/domain/repositories/signup_repository.dart';

Future<void> initServiceLocator() async {
  di.registerLazySingleton<TokenStorageService>(
    () => TokenStorageServiceImpl(storage: di<FlutterSecureStorage>()),
  );

  di.registerLazySingleton<UserDocumentStorageService>(
    () => UserDocumentStorageServiceImpl(storage: di<FlutterSecureStorage>()),
  );

  di.registerFactory<SigninRepository>(
    () => SigninRepositoryImpl(
      httpClient: di<HttpClient>(),
      tokenStorageService: di<TokenStorageService>(),
      userDocumentStorageService: di<UserDocumentStorageService>(),
    ),
  );

  di.registerFactory<SignupRepository>(
    () => SignupRepositoryImpl(
      httpClient: di<HttpClient>(),
      tokenStorageService: di<TokenStorageService>(),
      userDocumentStorageService: di<UserDocumentStorageService>(),
    ),
  );
}
