abstract class SessionManager {
  Future<void> onSessionExpired();
  Future<bool> hasSession();
}

class SessionManagerLazy implements SessionManager {
  SessionManagerLazy(this._factory);

  final SessionManager Function() _factory;

  @override
  Future<void> onSessionExpired() => _factory().onSessionExpired();

  @override
  Future<bool> hasSession() => _factory().hasSession();
}
