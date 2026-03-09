import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:user_credentials/user_credentials.dart';

import 'options/data/repositories/options_repository_impl.dart';
import 'options/domain/repositories/options_repository.dart';

Future<void> initServiceLocator() async {
  di.registerFactory<OptionsRepository>(
    () => OptionsRepositoryImpl(
      tokenStorageService: di<TokenStorageService>(),
      userDocumentStorageService: di<UserDocumentStorageService>(),
      credentialStorageService: di<CredentialStorageService>(),
    ),
  );
}
