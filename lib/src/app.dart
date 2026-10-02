import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/generated/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/items/presentation/controllers/item_controller.dart';
import 'features/items/presentation/screens/home_screen.dart';
import 'features/settings/presentation/controllers/settings_controller.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

class MyApp extends StatelessWidget {
  final SettingsController settingsController;
  final ItemController itemController;

  const MyApp({
    super.key,
    required this.settingsController,
    required this.itemController,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: settingsController.themeMode,
          locale: settingsController.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(
            itemController: itemController,
            settingsWidget: SettingsScreen(
              settingsController: settingsController,
            ),
          ),
        );
      },
    );
  }
}
