import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/data/repositories/settings_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/domain/models/app_settings.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/controllers/settings_controller.dart';

void main() {
  group('SettingsController Tests', () {
    late MemorySettingsRepository repository;
    late SettingsController controller;

    setUp(() {
      repository = MemorySettingsRepository(
        initialSettings: const AppSettings(
          locale: Locale('fr'),
          themeMode: ThemeMode.system,
        ),
      );
      controller = SettingsController(repository: repository);
    });

    test('loadSettings initializes settings properly', () async {
      expect(controller.isInitialized, false);

      await controller.loadSettings();

      expect(controller.isInitialized, true);
      expect(controller.locale, const Locale('fr'));
      expect(controller.themeMode, ThemeMode.system);
    });

    test('updateLocale updates settings and persists changes', () async {
      await controller.loadSettings();

      bool notified = false;
      controller.addListener(() {
        notified = true;
      });

      await controller.updateLocale(const Locale('en'));

      expect(controller.locale, const Locale('en'));
      expect(notified, true);

      final savedSettings = await repository.loadSettings();
      expect(savedSettings.locale, const Locale('en'));
    });

    test('updateThemeMode updates settings and persists changes', () async {
      await controller.loadSettings();

      bool notified = false;
      controller.addListener(() {
        notified = true;
      });

      await controller.updateThemeMode(ThemeMode.dark);

      expect(controller.themeMode, ThemeMode.dark);
      expect(notified, true);

      final savedSettings = await repository.loadSettings();
      expect(savedSettings.themeMode, ThemeMode.dark);
    });
  });
}
