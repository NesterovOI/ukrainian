import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/features/exam/domain/usecases/export_usecase.dart';
import 'package:ukrainian/features/exam/presentation/providers/exam_state.dart';
import 'package:ukrainian/core/services/nmt_score_calculator.dart';
import 'package:ukrainian/core/theme/app_strings.dart';

class ExamController extends StateNotifier<ExamState> {
  final GetExamUseCase _getExamUseCase;
  final SaveExamResultUseCase _saveExamResultUseCase;
  Timer? _timer;

  ExamController({
    required GetExamUseCase getExamUseCase,
    required SaveExamResultUseCase saveExamResultUseCase,
  }) : _getExamUseCase = getExamUseCase,
       _saveExamResultUseCase = saveExamResultUseCase,
       super(const ExamState());

  /// Ініціалізація та запуск складання екзамену
  Future<void> startExam(String examId) async {
    state = state.copyWith(status: ExamStatus.loading);
    try {
      final exam = await _getExamUseCase.call(examId);
      state = state.copyWith(
        status: ExamStatus.inProgress,
        exam: exam,
        currentQuestionIndex: 0,
        userAnswer: {},
        timeRemainingSeconds: exam.timeLimitMinutes * 60,
      );
      _startTime();
    } catch (e) {
      state = state.copyWith(
        status: ExamStatus.error,
        errorMessage: AppStrings.notLoadExam + e.toString(),
      );
    }
  }

  void _startTime() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeRemainingSeconds > 0) {
        state = state.copyWith(
          timeRemainingSeconds: state.timeRemainingSeconds - 1,
        );
      } else {
        _timer?.cancel();
        finishExam();
      }
    });
  }

  /// Перехід до конкретного питання
  void goToQuestion(int index) {
    if (index >= 0 && index < state.totalQuestion) {
      state = state.copyWith(currentQuestionIndex: index);
    }
  }

  /// Вибір відповіді для питання з поодиноким вибором (Single Choice / Accent / Text Input)
  void selectSingleAnswer(int optionIndex) {
    final answers = Map<int, QuestionAnswer>.from(state.userAnswer);
    final currentAns =
        answers[state.currentQuestionIndex] ?? const QuestionAnswer();
    answers[state.currentQuestionIndex] = QuestionAnswer(
      selectedOptionIndex: optionIndex,
      matchingPairs: currentAns.matchingPairs,
      isFlagged: currentAns.isFlagged,
    );

    state = state.copyWith(userAnswer: answers);
  }

  /// Встановлення відповідності для питань типу Matching (1-А, 2-В...)
  void setMatchingAnswer(int leftIndex, int rightIndex) {
    final answers = Map<int, QuestionAnswer>.from(state.userAnswer);
    final currentAns =
        answers[state.currentQuestionIndex] ?? const QuestionAnswer();
    final currentPairs = Map<int, int>.from(currentAns.matchingPairs ?? {});

    currentPairs[leftIndex] = rightIndex;

    answers[state.currentQuestionIndex] = QuestionAnswer(
      selectedOptionIndex: currentAns.selectedOptionIndex,
      matchingPairs: currentPairs,
      isFlagged: currentAns.isFlagged,
    );

    state = state.copyWith(userAnswer: answers);
  }

  /// Позначити/зняти прапорець сумніву з питання
  void toggleFlagCurrentQuestion() {
    final answers = Map<int, QuestionAnswer>.from(state.userAnswer);
    final currentAns =
        answers[state.currentQuestionIndex] ?? const QuestionAnswer();
    answers[state.currentQuestionIndex] = QuestionAnswer(
      selectedOptionIndex: currentAns.selectedOptionIndex,
      matchingPairs: currentAns.matchingPairs,
      isFlagged: !currentAns.isFlagged,
    );

    state = state.copyWith(userAnswer: answers);
  }

  /// Завершення екзамену та збереження в Drift
  Future<void> finishExam() async {
    _timer?.cancel();
    final currentExam = state.exam;

    if (currentExam == null) return;
    final timeSpent =
        (currentExam.timeLimitMinutes * 60) - state.timeRemainingSeconds;
    //Підрахунок балів
    int rawScore = 0;
    for (int i = 0; i < currentExam.question.length; i++) {
      final q = currentExam.question[i];
      final userAns = state.userAnswer[i];
      if (userAns != null) {
        rawScore += q.calculateScore(userAns);
      }
    }

    final nmtScore = NmtScoreCalculator.calculateNMTScore(rawScore);
    final resultEntity = ExamResultEntity(
      examId: currentExam.id,
      examTitle: currentExam.title,
      rawScore: rawScore,
      nmtScore: nmtScore,
      maxRawScore: currentExam.maxRawScore,
      timeSpendSeconds: timeSpent,
      completedAt: DateTime.now(),
      userAnswer: state.userAnswer,
    );

    await _saveExamResultUseCase.call(resultEntity);
    state = state.copyWith(status: ExamStatus.finished);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
