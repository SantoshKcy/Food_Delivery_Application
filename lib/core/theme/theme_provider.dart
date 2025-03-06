import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default theme is Light

  ThemeProvider() {
    _loadThemePreference(); // Load theme when app starts
  }

  ThemeMode get themeMode => _themeMode;

  // 🔹 Load Theme Preference from System
  void _loadThemePreference() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _themeMode = (brightness == Brightness.dark) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // 🔹 Toggle Dark Mode & Save Preference
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
