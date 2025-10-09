import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static SharedPreferences? _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> set<T>(String key, T value) {
    if (_preferences == null) {
      debugPrint('StorageUtil, need call await init() first');
      return Future.value(false);
    }

    String type = value.runtimeType.toString();
    switch (type) {
      case "String":
        return _preferences!.setString(key, value as String);
      case "int":
        return _preferences!.setInt(key, value as int);
      case "bool":
        return _preferences!.setBool(key, value as bool);
      case "double":
        return _preferences!.setDouble(key, value as double);
      case "List<String>":
        return _preferences!.setStringList(key, value as List<String>);
      case "_InternalLinkedHashMap<String, String>":
        return _preferences!.setString(key, json.encode(value));
      default:
        return Future.value(false);
    }
  }

  static Object? get(String key) {
    if (_preferences == null) {
      debugPrint('StorageUtil, need call await init() first');
      return null;
    }

    Object? value = _preferences!.get(key);
    return value;
  }

  static Future<bool> remove(String key) {
    if (_preferences == null) {
      debugPrint('StorageUtil, need call await init() first');
      return Future.value(false);
    }

    return _preferences!.remove(key);
  }
}
