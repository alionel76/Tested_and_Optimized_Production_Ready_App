import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/core/localization/generated/app_localizations.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/data/repositories/settings_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/screens/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen displays language and theme options in French',
      (WidgetTester tester) async {
    final repository = MemorySettingsRepository();
    final controller = SettingsController(repository: repository);
    await controller.loadSettings();

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(settingsController: controller),
      ),
    );

    await tester.pump();

    expect(find.text('Langue'), findsOneWidget);
    expect(find.text('Mode Thème'), findsOneWidget);
    expect(find.text('Français'), findsOneWidget);
    expect(find.text('Anglais'), findsOneWidget);
  });
}
