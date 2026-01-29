import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ChangeTheme extends SettingsEvent {
  const ChangeTheme(this.themeMode);
  final ThemeMode themeMode;
  @override
  List<Object?> get props => [themeMode];
}

class ChangeLocale extends SettingsEvent {
  const ChangeLocale(this.locale);
  final Locale locale;
  @override
  List<Object?> get props => [locale];
}
