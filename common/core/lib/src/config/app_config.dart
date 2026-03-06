enum Environment { hml, prod }

abstract final class AppConfig {
  AppConfig._();

  static const _env = String.fromEnvironment('ENV', defaultValue: 'hml');

  static Environment get environment =>
      _env == 'prod' ? Environment.prod : Environment.hml;

  static String get baseUrl => switch (environment) {
    Environment.hml =>
      'https://subthoracal-irresoluble-magdalen.ngrok-free.dev/api/v1', //'https://vtn-hml.valid-cross-service.app/api/v1',
    Environment.prod => 'https://vtn.valid-cross-service.app/api/v1',
  };
}
