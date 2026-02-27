import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'authentication.dart';
import 'signin/data/repositories/signin_repository_impl.dart';
import 'signin/domain/repositories/signin_repository.dart';

Future<void> initServiceLocator() async {
  di.registerLazySingleton<UserDocumentStorageService>(
    () => UserDocumentStorageServiceImpl(storage: di<FlutterSecureStorage>()),
  );

  di.registerFactory<SigninRepository>(
    () => SigninRepositoryImpl(
      userDocumentStorageService: di<UserDocumentStorageService>(),
    ),
  );
}
