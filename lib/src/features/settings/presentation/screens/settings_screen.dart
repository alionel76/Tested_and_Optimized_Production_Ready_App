// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController settingsController;

  const SettingsScreen({
    super.key,
    required this.settingsController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: settingsController,
      builder: (context, _) {
        final currentLocale = settingsController.locale;
        final currentThemeMode = settingsController.themeMode;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.settingsTitle),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Semantics(
                header: true,
                child: Text(
                  l10n.language,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text(l10n.french),
                      value: 'fr',
                      groupValue: currentLocale.languageCode,
                      onChanged: (value) {
                        if (value != null) {
                          settingsController.updateLocale(Locale(value));
                        }
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(l10n.english),
                      value: 'en',
                      groupValue: currentLocale.languageCode,
                      onChanged: (value) {
                        if (value != null) {
                          settingsController.updateLocale(Locale(value));
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                header: true,
                child: Text(
                  l10n.themeMode,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text(l10n.system),
                      value: ThemeMode.system,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        if (value != null) {
                          settingsController.updateThemeMode(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(l10n.light),
                      value: ThemeMode.light,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        if (value != null) {
                          settingsController.updateThemeMode(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(l10n.dark),
                      value: ThemeMode.dark,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        if (value != null) {
                          settingsController.updateThemeMode(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
