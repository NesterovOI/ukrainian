import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

abstract class UserProgressRepository {
  Future<void> logAnswer({
    required String lessonId,
    required String subcategory,
    required String questionId,
    required bool isCorrect,
  });

  Future<List<SubcategoryAnalyticsEntity>> getSubcategoryAnalytics();
}
