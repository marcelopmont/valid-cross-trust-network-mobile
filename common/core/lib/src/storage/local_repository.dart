import 'package:dependencies/dependencies.dart';

typedef GetJsonBaseModel<T> = T Function(String jsonRaw);

abstract class ToJson {
  String toJson();
}

abstract class LocalRepository<T> {
  const LocalRepository();

  Future<T?> get();
  Future<T> save(T model);
  Future<void> delete();
}

class LocalRepositoryImpl<X extends ToJson> extends LocalRepository<X> {
  LocalRepositoryImpl({
    required this.storage,
    required this.baseModel,
    this.defaultValue,
  }) : key = 'key:$X';

  final FlutterSecureStorage storage;
  final GetJsonBaseModel baseModel;
  final String? defaultValue;
  final String key;

  @override
  Future<X?> get() async {
    final storedAppContact = await storage.read(key: key);
    if (storedAppContact?.isNotEmpty == true) {
      return baseModel(storedAppContact!);
    } else if (defaultValue?.isNotEmpty == true) {
      return baseModel(defaultValue!);
    }
    return Future.value(null);
  }

  @override
  Future<X> save(X model) async {
    await storage.write(key: key, value: model.toJson());
    return model;
  }

  @override
  Future<void> delete() {
    return storage.delete(key: key);
  }
}
