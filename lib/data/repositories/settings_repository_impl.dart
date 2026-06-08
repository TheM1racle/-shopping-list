import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';
import '../models/app_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._datasource);

  final SettingsLocalDatasource _datasource;

  @override
  Future<AppSettings> getSettings() async {
    return _datasource.getSettings().toEntity();
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _datasource.saveSettings(AppSettingsModel.fromEntity(settings));
  }
}
