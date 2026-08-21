import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';

class LogAnswerUseCase {
  final UserProgressRepository _repository;

  LogAnswerUseCase(this._repository);

  Future<void> call({
    required String lessonId,
    required String subcategory,
    required String questionId,
    required bool isCorrect,
  }) async {
    await _repository.logAnswer(
      lessonId: lessonId,
      subcategory: subcategory,
      questionId: questionId,
      isCorrect: isCorrect,
    );
  }
}
