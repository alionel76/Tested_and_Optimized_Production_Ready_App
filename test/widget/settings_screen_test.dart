import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/data/repositories/settings_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/screens/settings_screen.dart';

import '../test_helpers.dart';

void main() {
  group('SettingsScreen Widget Tests', () {
    late MemorySettingsRepository repository;
    late SettingsController settingsController;

    setUp(() {
      repository = MemorySettingsRepository();
      settingsController = SettingsController(repository: repository);
    });

    testWidgets('SettingsScreen displays language and theme options', (WidgetTester tester) async {
      await settingsController.loadSettings();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: SettingsScreen(
            settingsController: settingsController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Langue'), findsOneWidget);
      expect(find.text('Français'), findsOneWidget);
      expect(find.text('Anglais'), findsOneWidget);
      expect(find.text('Mode Thème'), findsOneWidget);
      expect(find.text('Système'), findsOneWidget);
      expect(find.text('Clair'), findsOneWidget);
      expect(find.text('Sombre'), findsOneWidget);
    });

    testWidgets('Tapping English updates settingsController locale', (WidgetTester tester) async {
      await settingsController.loadSettings();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: SettingsScreen(
            settingsController: settingsController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(settingsController.locale, const Locale('fr'));

      await tester.tap(find.text('Anglais'));
      await tester.pumpAndSettle();

      expect(settingsController.locale, const Locale('en'));
    });
  });
}
