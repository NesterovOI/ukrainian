import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';

class GetSettingsUseCase {
  final ProfileSettingsRepository _repository;

  GetSettingsUseCase(this._repository);

  Future<SettingsEntity?> call() async => await _repository.getSetting();
}
