import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'src/http/http_client.dart';

Future<void> initServiceLocator() async {
  di.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppConfig.baseUrl)),
  );

  di.registerFactory<HttpClient>(() => HttpClientImpl(dio: di()));
}
