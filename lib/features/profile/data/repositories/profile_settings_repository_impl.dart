import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/data/datasources/local_storage_data_source.dart';

class ProfileSettingsRepositoryImpl implements ProfileSettingsRepository {
  final LocalStorageDataSource _source;

  ProfileSettingsRepositoryImpl(this._source);

  @override
  Future<bool> saveSettings(SettingsEntity settings) =>
      _source.saveSettings(settings);
  @override
  Future<SettingsEntity?> getSettingPush() => _source.getSettings();
}
