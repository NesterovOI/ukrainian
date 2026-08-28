import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';
import 'package:ukrainian/core/theme/theme.dart';

class GetFailedQuestionsUseCase {
  final UserProgressRepository _repository;

  GetFailedQuestionsUseCase(this._repository);

  Future<LessonEntity?> call(List<LessonEntity> allLessons) async {
    final failedQuestionIds = await _repository.getFailedQuestionIds();

    if (failedQuestionIds.isEmpty) return null;

    final List<QuizQuestionEntity> failedQuestions = [];

    for (final lesson in allLessons) {
      for (final question in lesson.questions) {
        if (failedQuestionIds.contains(question.id)) {
          failedQuestions.add(question);
        }
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
