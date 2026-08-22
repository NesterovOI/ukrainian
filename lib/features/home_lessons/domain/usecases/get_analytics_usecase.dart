import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';

class GetAnalyticsUseCase {
  final UserProgressRepository _repository;

  GetAnalyticsUseCase(this._repository);

  Future<List<SubcategoryAnalyticsEntity>> call() async {
    return await _repository.getSubcategoryAnalytics();
  }
}
