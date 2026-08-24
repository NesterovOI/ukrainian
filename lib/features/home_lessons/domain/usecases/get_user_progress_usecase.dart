import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';

class GetUserProgressUseCase {
  final UserProgressRepository _repository;

  GetUserProgressUseCase(this._repository);

  Future<UserProgressEntity> call() async {
    return await _repository.getUserProgress();
  }
}
