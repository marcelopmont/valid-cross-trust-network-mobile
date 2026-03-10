import 'package:dependencies/dependencies.dart';

import 'session_manager.dart';

class UnauthorizedInterceptor extends Interceptor {
  UnauthorizedInterceptor({required this.sessionManager});

  final SessionManager sessionManager;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      sessionManager.onSessionExpired();

      handler.resolve(
        Response(requestOptions: err.requestOptions, statusCode: 401),
      );
      return;
    }

    super.onError(err, handler);
  }
}
