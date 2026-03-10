abstract class SessionManager {
  Future<void> onSessionExpired();
}

class SessionManagerLazy implements SessionManager {
  SessionManagerLazy(this._factory);

  final SessionManager Function() _factory;

  @override
  Future<void> onSessionExpired() => _factory().onSessionExpired();
}
