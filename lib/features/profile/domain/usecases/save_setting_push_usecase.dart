import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

class SaveSettingPushUseCase {
  final ProfileSettingsRepository _repository;

  SaveSettingPushUseCase(this._repository);

  Future<bool> call(SettingsEntity value) async {
    return _repository.saveSettingPush(value);
  }
}
