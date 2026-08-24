import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';
import 'package:ukrainian/core/theme/theme.dart';

class GetFailedQuestionsUseCase {
  final UserProgressRepository _repository;

  GetFailedQuestionsUseCase(this._repository);

  Future<LessonEntity?> call(List<LessonEntity> allLessons) async {
    final analitics = await _repository.getSubcategoryAnalytics();

    // Знаходимо назви тем, де accuracyPercentage < 70%
    final weakSubcategoris = analitics
        .where((item) => item.accuratePercentage < 70)
        .map((item) => item.subcategoryId)
        .toSet();

    if (weakSubcategoris.isEmpty) return null;

    // Відбираємо питання тільки з цих проблемних тем
    final List<QuizQuestionEntity> failedQuestions = [];
    for (final lesson in allLessons) {
      if (weakSubcategoris.contains(lesson.categoryTitle)) {
        failedQuestions.addAll(lesson.questions);
      }
    }

    if (failedQuestions.isEmpty) return null;
    // Створюю віртуальний "Урок над помилками"
    return LessonEntity(
      id: AppStrings.lessonEntityId,
      categoryTitle: AppStrings.lessonEntityCategoryTitle,
      title: AppStrings.lessonEntityTitle,
      description: AppStrings.lessonEntityDescription,
      order: 0,
      isFree: true,
      theoryMarkdown: AppStrings.lessonEntityTheoryMarkdown,
      questions: failedQuestions,
    );
  }
}
