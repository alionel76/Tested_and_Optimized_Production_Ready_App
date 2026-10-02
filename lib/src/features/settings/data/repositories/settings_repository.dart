import '../../domain/models/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings> loadSettings();
  Future<void> saveSettings(AppSettings settings);
}

class MemorySettingsRepository implements SettingsRepository {
  AppSettings _settings;

  MemorySettingsRepository({AppSettings initialSettings = const AppSettings()})
      : _settings = initialSettings;

  @override
  Future<AppSettings> loadSettings() async {
    return _settings;
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    _settings = settings;
  }
}
