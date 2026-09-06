import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

abstract class ProfileSettingsRepository {
  Future<bool> saveSettings(SettingsEntity settings);
  Future<SettingsEntity?> getSetting();
}
