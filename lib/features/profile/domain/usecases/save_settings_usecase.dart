import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';

class SaveSettingsUseCase {
  final ProfileSettingsRepository _repository;

  SaveSettingsUseCase(this._repository);

  Future<bool> call(SettingsEntity settings) async =>
      await _repository.saveSettings(settings);
}
