import 'package:core/core.dart';
import 'package:network/network.dart';

import 'src/consent/data/repositories/consent_repository_impl.dart';
import 'src/consent/domain/repositories/consent_repository.dart';
import 'src/credentials_list/data/repositories/credentials_repository_impl.dart';
import 'src/credentials_list/domain/repositories/credentials_repository.dart';
import 'src/liveness/data/services/liveness_hub_service.dart';

Future<void> initServiceLocator() async {
  di.registerLazySingleton<LivenessHubService>(LivenessHubService.new);

  di.registerFactory<CredentialsRepository>(
    () => CredentialsRepositoryImpl(httpClient: di<HttpClient>()),
  );

  di.registerFactory<ConsentRepository>(
    () => ConsentRepositoryImpl(httpClient: di<HttpClient>()),
  );
}
