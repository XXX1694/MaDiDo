import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/features/settings/data/repositories/settings_repository.dart';

void main() {
  group('SettingsRepositoryImpl', () {
    late SettingsRepository repository;
    late SharedPreferences sharedPreferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      sharedPreferences = await SharedPreferences.getInstance();
      repository = SettingsRepositoryImpl(sharedPreferences);
    });

    tearDown(() async {
      await sharedPreferences.clear();
    });

    group('getThemeMode', () {
      test('returns system by default', () async {
        final themeMode = await repository.getThemeMode();
        expect(themeMode, equals(ThemeMode.system));
      });

      test('returns dark when dark is saved', () async {
        await sharedPreferences.setInt('themeMode', ThemeMode.dark.index);
        final themeMode = await repository.getThemeMode();
        expect(themeMode, equals(ThemeMode.dark));
      });

      test('returns light when light is saved', () async {
        await sharedPreferences.setInt('themeMode', ThemeMode.light.index);
        final themeMode = await repository.getThemeMode();
        expect(themeMode, equals(ThemeMode.light));
      });
    });

    group('setThemeMode', () {
      test('saves dark theme mode', () async {
        await repository.setThemeMode(ThemeMode.dark);
        final saved = sharedPreferences.getInt('themeMode');
        expect(saved, equals(ThemeMode.dark.index));
      });

      test('saves light theme mode', () async {
        await repository.setThemeMode(ThemeMode.light);
        final saved = sharedPreferences.getInt('themeMode');
        expect(saved, equals(ThemeMode.light.index));
      });

      test('saves system theme mode', () async {
        await repository.setThemeMode(ThemeMode.system);
        final saved = sharedPreferences.getInt('themeMode');
        expect(saved, equals(ThemeMode.system.index));
      });

      test('overwrites existing value', () async {
        await repository.setThemeMode(ThemeMode.dark);
        await repository.setThemeMode(ThemeMode.light);
        final saved = sharedPreferences.getInt('themeMode');
        expect(saved, equals(ThemeMode.light.index));
      });
    });

    group('getLocale', () {
      test('returns default locale (en) by default', () async {
        final locale = await repository.getLocale();
        expect(locale.languageCode, equals('en'));
      });

      test('returns saved locale', () async {
        await sharedPreferences.setString('languageCode', 'ru');
        final locale = await repository.getLocale();
        expect(locale.languageCode, equals('ru'));
      });

      test('handles different language codes', () async {
        await sharedPreferences.setString('languageCode', 'kk');
        final locale = await repository.getLocale();
        expect(locale.languageCode, equals('kk'));
      });
    });

    group('setLocale', () {
      test('saves locale language code', () async {
        const locale = Locale('en');
        await repository.setLocale(locale);
        final saved = sharedPreferences.getString('languageCode');
        expect(saved, equals('en'));
      });

      test('saves different language codes', () async {
        const locale = Locale('kk');
        await repository.setLocale(locale);
        final saved = sharedPreferences.getString('languageCode');
        expect(saved, equals('kk'));
      });

      test('overwrites existing locale', () async {
        await repository.setLocale(const Locale('en'));
        await repository.setLocale(const Locale('ru'));
        final saved = sharedPreferences.getString('languageCode');
        expect(saved, equals('ru'));
      });
    });

    group('integration tests', () {
      test('can save and retrieve theme mode', () async {
        await repository.setThemeMode(ThemeMode.dark);
        final retrieved = await repository.getThemeMode();
        expect(retrieved, equals(ThemeMode.dark));
      });

      test('can save and retrieve locale', () async {
        const locale = Locale('ru');
        await repository.setLocale(locale);
        final retrieved = await repository.getLocale();
        expect(retrieved.languageCode, equals('ru'));
      });

      test('theme mode persists across repository instances', () async {
        await repository.setThemeMode(ThemeMode.dark);
        final newRepository = SettingsRepositoryImpl(sharedPreferences);
        final retrieved = await newRepository.getThemeMode();
        expect(retrieved, equals(ThemeMode.dark));
      });

      test('locale persists across repository instances', () async {
        await repository.setLocale(const Locale('kk'));
        final newRepository = SettingsRepositoryImpl(sharedPreferences);
        final retrieved = await newRepository.getLocale();
        expect(retrieved.languageCode, equals('kk'));
      });
    });
  });
}
