import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';

enum ExamStatus { initial, loading, inProgress, finished, error }

class ExamState {
  final ExamStatus status;
  final ExamEntity? exam;
  final int currentQuestionIndex;
  final Map<int, QuestionAnswer> userAnswer;
  final int timeRemainingSeconds;
  final String? errorMessage;

  const ExamState({
    this.status = ExamStatus.initial,
    this.exam,
    this.currentQuestionIndex = 0,
    this.userAnswer = const {},
    this.timeRemainingSeconds = 3600,
    this.errorMessage,
  });

  ExamQuestionEntity? get currentQuestion {
    final currentExam = exam;
    if (currentExam == null ||
        currentQuestionIndex >= currentExam.question.length) {
      return null;
    }
    return currentExam.question[currentQuestionIndex];
  }

  bool get isLastQuestion {
    final currentExam = exam;
    if (currentExam == null) return false;
    return currentQuestionIndex == currentExam.question.length - 1;
  }

  int get totalQuestion => exam?.question.length ?? 0;

  ExamState copyWith({
    final ExamStatus? status,
    final ExamEntity? exam,
    final int? currentQuestionIndex,
    final Map<int, QuestionAnswer>? userAnswer,
    final int? timeRemainingSeconds,
    final String? errorMessage,
  }) {
    return ExamState(
      status: status ?? this.status,
      exam: exam ?? this.exam,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswer: userAnswer ?? this.userAnswer,
      timeRemainingSeconds: timeRemainingSeconds ?? this.timeRemainingSeconds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
