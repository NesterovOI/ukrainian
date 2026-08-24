import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';

class SaveUserProgressUseCase {
  final UserProgressRepository _repository;

  SaveUserProgressUseCase(this._repository);

  Future<void> call(UserProgressEntity progress) async {
    await _repository.saveUserProgress(progress);
  }
}
