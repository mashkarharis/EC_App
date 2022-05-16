import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreService {
  static Future<void> add(String key, String value) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String?> get(String key) async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static Future<void> clean() async {
    final storage = FlutterSecureStorage();
    return await storage.deleteAll();
  }
}
