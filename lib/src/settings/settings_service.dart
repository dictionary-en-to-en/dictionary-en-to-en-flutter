import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  SharedPreferences? _sharedPreferences;

  SettingsService();

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    final themeModeString = _sharedPreferences!.getString('themeMode');
    if (themeModeString == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values[int.parse(themeModeString)];
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    _sharedPreferences!.setString('themeMode', theme.index.toString());
  }
}
