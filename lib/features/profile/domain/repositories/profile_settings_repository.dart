import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

abstract class ProfileSettingsRepository {
  Future<bool?> getSettingPush();
  Future<void> saveSettingPush(SettingsEntity value);
  Future<bool?> getSettingTheme();
  Future<void> saveSettingTheme(SettingsEntity value);
}
