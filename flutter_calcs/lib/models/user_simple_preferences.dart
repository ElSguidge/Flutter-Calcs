import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  static init() async => _preferences = await SharedPreferences.getInstance();

  static String getUsername() => _preferences!.getString(_keyUsername) ?? '';
}
