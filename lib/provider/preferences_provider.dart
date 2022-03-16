/*
  Dark Theme Provider class.
  Approach to setting and getting value of app preferences.
  Like DarkTheme, Language and locale, app status, and etc...
*/
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  ///
  /// A class made for insert and read {key: value} data in LocalStorage.
  /// Your set anythings by adding type in setter function.
  setPreferences({String? key, dynamic value, String? type}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (type == "bool") sharedPreferences.setBool(key!, value);
    if (type == "String") sharedPreferences.setString(key!, value);
  }

  Future<dynamic> getPreferences(String type, String? key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (type == "bool") return sharedPreferences.getBool(key!) ?? false;
    if (type == "String") return sharedPreferences.getString(key!) ?? "";
  }
}

class DarkThemeProvider with ChangeNotifier {
  ///
  /// Dark Theme Provider will save and put state of isDark value in
  /// Highest priority of all widgets and developer can access to it's value,
  /// super simple.
  PreferencesProvider preferencesProvider = PreferencesProvider();
  // Default value is false for _isDark value.
  bool _isDark = false;

  bool get isDark => _isDark;

  set darkTheme(bool value) {
    _isDark = value;
    preferencesProvider.setPreferences(
      key: "darkTheme",
      value: value,
      type: "bool",
    );

    notifyListeners();
  }
}
