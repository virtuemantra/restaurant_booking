import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';

class Preference {
  static const _IS_LOGIN = "is_login";

  static const _USER = 'user_5684';
  // static User? _user;

  // static String _ENC_KEYS_567;

  static SharedPreferences? _pref;

  static Future<bool> init() async {
    // SharedPreferences.setMockInitialValues({});
    _pref = await SharedPreferences.getInstance();
    return true;
  }

  static bool containsKey(String key) => _pref!.containsKey(key);

  // static bool get isUserAvailable =>
  //     _pref!.containsKey(_USER) && _pref!
  //         .getString(_USER)
  //         .notEmpty;
  //
  // static User? get user {
  //   _user ??= User.fromJson(jsonDecode(_pref?.getString(_USER) ?? '{}'));
  //   return _user;
  // }

  // static void setUser(User u) {
  //   if (u.id.notEmpty) {
  //     _user = u;
  //     _pref?.setString(_USER, jsonEncode(u.toJson()));
  //   } else {
  //     Logger.e(tag: 'INVALID USER', value: u.toJson());
  //   }
  // }

  //Check Login or not?
  static bool get isLogin => _pref?.getBool(_IS_LOGIN) ?? false;
  //
  static Future<void> setLogin(bool login) => _pref!.setBool(_IS_LOGIN, login);
  //
  // static void clear() => _pref?.clear();
}
