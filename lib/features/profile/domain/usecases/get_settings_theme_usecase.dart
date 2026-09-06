import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

class GetSettingsThemeUseCase {
  final ProfileSettingsRepository _repository;

  GetSettingsThemeUseCase(this._repository);

  Future<SettingsEntity?> call() async {
    return _repository.getSettingTheme();
  }
}
