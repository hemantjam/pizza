import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static saveStringList(String key, List<String> data) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setStringList(key, data));
  }

  static Future<List<String>?> fetchStringList(String key) async {
    return await SharedPreferences.getInstance()
        .then((value) => value.getStringList(key));
  }

  static Future<String?> fetchString(String key) async {
    return await SharedPreferences.getInstance()
        .then((value) => value.getString(key));
  }

  static saveString(String key, String data) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString(key, data));
  }

  static deleteData(key) {
    SharedPreferences.getInstance().then((value) => value.remove(key));
  }
}
