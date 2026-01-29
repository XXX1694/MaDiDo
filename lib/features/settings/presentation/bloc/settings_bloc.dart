import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/features/settings/data/repositories/settings_repository.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_event.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepository repository})
    : _repository = repository,
      super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeTheme>(_onChangeTheme);
    on<ChangeLocale>(_onChangeLocale);
  }

  final SettingsRepository _repository;

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final themeMode = await _repository.getThemeMode();
    final locale = await _repository.getLocale();
    emit(state.copyWith(themeMode: themeMode, locale: locale));
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }
}
