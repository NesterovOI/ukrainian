import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

class GetSettingsPushUseCase {
  final ProfileSettingsRepository _repository;

  GetSettingsPushUseCase(this._repository);

  Future<SettingsEntity?> call() async {
    return await _repository.getSettingPush();
  }
}
