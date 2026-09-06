import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

abstract class ProfileSettingsRepository {
  Future<SettingsEntity?> getSettingPush();
  Future<bool> saveSettingPush(SettingsEntity value);
  Future<SettingsEntity?> getSettingTheme();
  Future<bool> saveSettingTheme(SettingsEntity value);
}
