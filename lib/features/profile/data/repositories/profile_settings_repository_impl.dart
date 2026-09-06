import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/data/datasources/local_storage_data_source.dart';

class ProfileSettingsRepositoryImpl implements ProfileSettingsRepository {
  final LocalStorageDataSource _source;

  ProfileSettingsRepositoryImpl(this._source);
  @override
  Future<SettingsEntity?> getSettingPush() => _source.getPush();

  @override
  Future<SettingsEntity?> getSettingTheme() => _source.getTheme();

  @override
  Future<bool> saveSettingPush(SettingsEntity value) => _source.savePush(value);

  @override
  Future<bool> saveSettingTheme(SettingsEntity value) =>
      _source.saveTheme(value);
}
