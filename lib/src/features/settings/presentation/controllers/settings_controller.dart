// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';

import '../../data/repositories/settings_repository.dart';
import '../../domain/models/app_settings.dart';

class SettingsController extends ChangeNotifier {
  final SettingsRepository _repository;
  AppSettings _settings = const AppSettings();
  bool _isInitialized = false;

  SettingsController({required SettingsRepository repository})
      : _repository = repository;

  AppSettings get settings => _settings;
  Locale get locale => _settings.locale;
  ThemeMode get themeMode => _settings.themeMode;
  bool get isInitialized => _isInitialized;

  Future<void> loadSettings() async {
    _settings = await _repository.loadSettings();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (newLocale == _settings.locale) return;
    _settings = _settings.copyWith(locale: newLocale);
    notifyListeners();
    await _repository.saveSettings(_settings);
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == _settings.themeMode) return;
    _settings = _settings.copyWith(themeMode: newThemeMode);
    notifyListeners();
    await _repository.saveSettings(_settings);
  }
}
