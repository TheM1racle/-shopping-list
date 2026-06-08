import '../models/app_settings_model.dart';
import 'local_storage.dart';

class SettingsLocalDatasource {
  SettingsLocalDatasource(this._storage);

  final LocalStorage _storage;

  AppSettingsModel getSettings() {
    final raw = _storage.settingsBox.get(LocalStorage.settingsKey);
    if (raw is! Map) {
      return AppSettingsModel(themeModeIndex: 0, languageCode: 'ru');
    }
    return AppSettingsModel.fromMap(raw);
  }

  Future<void> saveSettings(AppSettingsModel settings) async {
    await _storage.settingsBox.put(
      LocalStorage.settingsKey,
      settings.toMap(),
    );
  }
}
