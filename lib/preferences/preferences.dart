import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';


class SessionManager {
  static Future<SharedPreferences> get _instance async =>  await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance ;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }


  static bool getBoolean(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }


  static Future<bool> setStringList(String key, List<String> value) async {
    var prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  static Future<bool> setBoolean(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool> removePref(String key)async{
    print("Remving prefs====>$key");
    var prefs = await _instance;
    return prefs.remove(key);


  }



//  static String getListString(String key, [String defValue]) {
//    return _prefsInstance.getStringList(key) ?? defValue ?? "";
//  }
//
//  static Future<bool> setListString(String key, List<dynamic> value) async {
//    var prefs = await _instance;
//    return prefs?.setStringList(key, value) ?? Future.value(false);
//  }


  static Future cleanPrefrence() async {
    await _prefsInstance?.clear();
  }
}