import 'package:dependencies/dependencies.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenProvider});

  final Future<String?> Function() tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
