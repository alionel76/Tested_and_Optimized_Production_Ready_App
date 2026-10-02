import 'package:flutter/material.dart';

class AppSettings {
  final Locale locale;
  final ThemeMode themeMode;

  const AppSettings({
    this.locale = const Locale('fr'),
    this.themeMode = ThemeMode.system,
  });

  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          locale == other.locale &&
          themeMode == other.themeMode;

  @override
  int get hashCode => locale.hashCode ^ themeMode.hashCode;
}
