import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/data/datasources/local_storage_data_source.dart';

class ProfileSettingsRepositoryImpl implements ProfileSettingsRepository {
  final LocalStorageDataSource _source;

  ProfileSettingsRepositoryImpl(this._source);
  @override
  Future<bool?> getSettingPush() => _source.getPush();

  @override
  Future<bool?> getSettingTheme() => _source.getTheme();

  @override
  Future<void> saveSettingPush(SettingsEntity value) => _source.savePush(value);

  @override
  Future<void> saveSettingTheme(SettingsEntity value) =>
      _source.saveTheme(value);
}
