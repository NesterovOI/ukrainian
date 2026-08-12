import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

enum QuizPageStep { theory, questions, result }

class QuizState {
  final LessonEntity lesson;
  final QuizPageStep step;
  final int currentQuestionIndex;
  final int? selectedOptionIndex;
  final bool? isAnswerCorrect;
  final int earnedScore;
  final bool isQuizFinished;

  const QuizState({
    required this.lesson,
    this.step = QuizPageStep.theory,
    this.currentQuestionIndex = 0,
    this.selectedOptionIndex,
    this.isAnswerCorrect,
    this.earnedScore = 0,
    this.isQuizFinished = false,
  });

  QuizState copyWith({
    LessonEntity? lesson,
    QuizPageStep? step,
    int? currentQuestionIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    bool? isAnswerCorrect,
    bool clearAnswerCorrect = false,
    int? earnedScore,
    bool? isQuizFinished,
  }) {
    return QuizState(
      lesson: lesson ?? this.lesson,
      step: step ?? this.step,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      isAnswerCorrect: clearAnswerCorrect
          ? null
          : (isAnswerCorrect ?? this.isAnswerCorrect),
      earnedScore: earnedScore ?? this.earnedScore,
      isQuizFinished: isQuizFinished ?? this.isQuizFinished,
    );
  }
}

class QuizController extends FamilyNotifier<QuizState, LessonEntity> {
  @override
  QuizState build(LessonEntity arg) {
    return QuizState(lesson: arg);
  }

  void startQuiz() {
    state = state.copyWith(step: QuizPageStep.questions);
  }

  void selectOption(int index) {
    if (state.selectedOptionIndex != null) return;
    state = state.copyWith(selectedOptionIndex: index);
  }

  bool answerQuestion() {
    final currentQ = state.lesson.question[state.currentQuestionIndex];
    final isCorrect = state.selectedOptionIndex == currentQ.correctOptionIndex;

    state = state.copyWith(
      isAnswerCorrect: isCorrect,
      earnedScore: isCorrect ? state.earnedScore + 10 : state.earnedScore,
    );
    return isCorrect;
  }

  bool nextQuestion() {
    if (state.currentQuestionIndex + 1 < state.lesson.question.length) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        clearSelectedOption: true,
        clearAnswerCorrect: true,
      );
      return false;
    } else {
      state = state.copyWith(step: QuizPageStep.result);
      return true;
    }
  }
}

final quizControllerProvider =
NotifierProvider.family<QuizController, QuizState, LessonEntity>(
  QuizController.new,
);