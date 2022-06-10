import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  SharedPreferences prefs;

  Cache(this.prefs);

  save(String key, value) {
    prefs.setString(key, json.encode(value));
  }

  Map<String, dynamic>? read(String key) {
    final jsonData = prefs.getString(key);
    if (jsonData != null) {
      Map<String, dynamic> map = json.decode(jsonData);
      return map;
    } else {
      return null;
    }
  }
}
