import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<bool> saveType(String? type) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TYPE.toString(), type);
    return true;
  }

  String getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString()) ?? "";
  }

  String? getType() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TYPE.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    await box.remove(CacheManagerKey.TYPE.toString());
  }
}

enum CacheManagerKey { TOKEN, TYPE }
