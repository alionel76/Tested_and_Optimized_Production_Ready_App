import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/data/repositories/settings_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/controllers/settings_controller.dart';

void main() {
  group('SettingsController Tests', () {
    late MemorySettingsRepository repository;
    late SettingsController controller;

    setUp(() {
      repository = MemorySettingsRepository();
      controller = SettingsController(repository: repository);
    });

    test('loadSettings initializes settings from repository', () async {
      await controller.loadSettings();
      expect(controller.isInitialized, isTrue);
      expect(controller.locale, const Locale('fr'));
    });

    test('updateLocale changes locale and saves settings', () async {
      await controller.loadSettings();
      await controller.updateLocale(const Locale('en'));

      expect(controller.locale, const Locale('en'));
      final savedSettings = await repository.loadSettings();
      expect(savedSettings.locale, const Locale('en'));
    });

    test('updateThemeMode changes themeMode and saves settings', () async {
      await controller.loadSettings();
      await controller.updateThemeMode(ThemeMode.dark);

      expect(controller.themeMode, ThemeMode.dark);
      final savedSettings = await repository.loadSettings();
      expect(savedSettings.themeMode, ThemeMode.dark);
    });
  });
}
