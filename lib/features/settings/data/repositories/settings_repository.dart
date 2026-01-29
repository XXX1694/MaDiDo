import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for managing app settings persistence
/// Abstracts SharedPreferences implementation from business logic
abstract class SettingsRepository {
  /// Load the current theme mode from storage
  Future<ThemeMode> getThemeMode();

  /// Save the theme mode to storage
  Future<void> setThemeMode(ThemeMode themeMode);

  /// Load the current locale from storage
  Future<Locale> getLocale();

  /// Save the locale to storage
  Future<void> setLocale(Locale locale);
}

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _themeModeKey = 'themeMode';
  static const String _languageCodeKey = 'languageCode';
  static const String _defaultLanguageCode = 'en';

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeIndex = _prefs.getInt(_themeModeKey) ?? 0;
    return ThemeMode.values[themeIndex];
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs.setInt(_themeModeKey, themeMode.index);
  }

  @override
  Future<Locale> getLocale() async {
    final languageCode =
        _prefs.getString(_languageCodeKey) ?? _defaultLanguageCode;
    return Locale(languageCode);
  }

  @override
  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_languageCodeKey, locale.languageCode);
  }
}
