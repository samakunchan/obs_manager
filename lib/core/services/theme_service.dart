import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Service responsible for loading, saving, and reacting to application theme mode changes.
class ThemeService {
  ThemeService(this._prefs) {
    _loadThemeMode();
  }

  static const String _keyThemeMode = 'app_theme_mode';
  final SharedPreferences _prefs;

  /// Reactive signal holding the current [ThemeMode].
  final Signal<ThemeMode> themeMode = signal<ThemeMode>(.system);

  /// Loads the theme mode from persistent storage.
  void _loadThemeMode() {
    final String? savedMode = _prefs.getString(_keyThemeMode);
    if (savedMode != null) {
      themeMode.value = ThemeMode.values.firstWhere(
        (ThemeMode mode) => mode.name == savedMode,
        orElse: () => .system,
      );
    }
  }

  /// Updates the theme mode and saves the choice persistently.
  Future<void> updateThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    await _prefs.setString(_keyThemeMode, mode.name);
  }
}
