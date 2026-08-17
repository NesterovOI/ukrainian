import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

enum QuizPageStep { theory, questions, result }

class QuizState {
  final LessonEntity lesson;
  final List<QuizQuestionEntity> activeQuestions;
  final QuizPageStep step;
  final int currentQuestionIndex;
  final int? selectedOptionIndex;
  final Map<int, int> selectedMatchingPairs;
  final int? activeLeftMatchingIndex;
  final bool? isAnswerCorrect;
  final int earnedScore;

  const QuizState({
    required this.lesson,
    required this.activeQuestions,
    this.step = QuizPageStep.theory,
    this.currentQuestionIndex = 0,
    this.selectedOptionIndex,
    this.selectedMatchingPairs = const {},
    this.activeLeftMatchingIndex,
    this.isAnswerCorrect,
    this.earnedScore = 0,
  });

  QuizState copyWith({
    LessonEntity? lesson,
    List<QuizQuestionEntity>? activeQuestion,
    QuizPageStep? step,
    int? currentQuestionIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    Map<int, int>? selectedMatchingPairs,
    int? activeLeftMatchingIndex,
    bool clearActiveLeft = false,
    bool? isAnswerCorrect,
    bool clearAnswerCorrect = false,
    int? earnedScore,
  }) {
    return QuizState(
      lesson: lesson ?? this.lesson,
      activeQuestions: activeQuestion ?? this.activeQuestions,
      step: step ?? this.step,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      selectedMatchingPairs: selectedMatchingPairs ?? this.selectedMatchingPairs,
      activeLeftMatchingIndex: clearActiveLeft
      ? null
      : (activeLeftMatchingIndex ?? this.activeLeftMatchingIndex),
      isAnswerCorrect: clearAnswerCorrect
          ? null
          : (isAnswerCorrect ?? this.isAnswerCorrect),
      earnedScore: earnedScore ?? this.earnedScore,
    );
  }
}

class QuizController extends FamilyNotifier<QuizState, LessonEntity> {
  @override
  QuizState build(LessonEntity arg) {
    final shuffled = List<QuizQuestionEntity>.from(arg.question)..shuffle(Random());
    final selectedQuestions = shuffled.take(5).toList();

    return QuizState(
        lesson: arg,
        activeQuestions: selectedQuestions,
    );
  }

  void startQuiz() {
    state = state.copyWith(step: QuizPageStep.questions);
  }

  void selectOption(int index) {
    if (state.selectedOptionIndex != null) return;
    state = state.copyWith(selectedOptionIndex: index);
  }

  void selectedMatchingLeft(int leftIndex) {
    if (state.isAnswerCorrect != null) return;
    state = state.copyWith(activeLeftMatchingIndex: leftIndex);
  }

  void selectedMatchingRight(int rightIndex) {
    if (state.isAnswerCorrect != null) return;
    if (state.activeLeftMatchingIndex == null) return;

    final updatedPairs = Map<int, int>.from(state.selectedMatchingPairs);
    updatedPairs[state.activeLeftMatchingIndex!] = rightIndex;

    state = state.copyWith(
      selectedMatchingPairs: updatedPairs,
      clearActiveLeft: true,
    );
  }

  bool answerQuestion() {
    final currentQ = state.lesson.question[state.currentQuestionIndex];
    bool isCorrect = false;

    if (currentQ.type == QuestionType.matching) {
      final correctPairs = currentQ.correctPairis ?? {};
      if (state.selectedMatchingPairs.length == correctPairs.length) {
          isCorrect = true;
          state.selectedMatchingPairs.forEach((left, right) {
            if (correctPairs[left] != right) {
              isCorrect = false;
            }
          });
      } else {
        isCorrect = state.selectedOptionIndex == currentQ.correctOptionIndex;
      }
    }

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
        selectedMatchingPairs: {},
        clearActiveLeft: true,
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