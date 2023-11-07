import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static saveAddress(String key,List<String> address) async {
    log("------->$address");
    await SharedPreferences.getInstance()
        .then((value) => value.setStringList(key, address));
  }

  static Future<List<String>?> getAddress(String key) async {
    return await SharedPreferences.getInstance()
        .then((value) => value.getStringList(key));
  }

  static deleteAddress(key) {
    SharedPreferences.getInstance().then((value) => value.remove(key));
  }
}
