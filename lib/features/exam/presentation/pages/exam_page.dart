import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/services/nmt_score_calculator.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/features/exam/domain/entities/exam_result_entity.dart';
import 'package:ukrainian/features/exam/presentation/providers/exam_providers.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/exam/presentation/providers/exam_state.dart';
import 'package:ukrainian/features/exam/presentation/widgets/exam_answer_widget.dart';

class ExamPage extends ConsumerStatefulWidget {
  final String examId;
  const ExamPage({super.key, required this.examId});

  @override
  ConsumerState<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends ConsumerState<ExamPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.examId.isNotEmpty) {
        ref.read(examControllerProvider.notifier).startExam(widget.examId);
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.exitExamTitle),
        content: const Text(AppStrings.exitExamContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.exitExamCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text(AppStrings.exitExamConfirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _onFinishPressed() async {
    final shouldFinish = await _showExitConfirmationDialog(context);
    if (shouldFinish && mounted) {
      ref.read(examControllerProvider.notifier).finishExam();
    }
  }

  @override
  Widget build(BuildContext context) {
    final examState = ref.watch(examControllerProvider);
    final controller = ref.read(examControllerProvider.notifier);

    if (examState.status == ExamStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (examState.status == ExamStatus.error) {
      return Scaffold(
        appBar: AppBar(title: Text(AppStrings.errorExam)),
        body: Center(
          child: Text(examState.errorMessage ?? AppStrings.errorMessage),
        ),
      );
    }

    final currentQuestion = examState.currentQuestion;

    ref.listen<ExamState>(examControllerProvider, (previous, next) {
      final exam = next.exam;
      if (next.status != ExamStatus.finished || exam == null) return;
      final timeSpent =
          (exam.timeLimitMinutes * 60) - next.timeRemainingSeconds;

      int rawScore = 0;
      for (int i = 0; i < exam.question.length; i++) {
        final question = exam.question[i];
        final userAnswer = next.userAnswer[i];
        if (userAnswer != null) {
          rawScore += question.calculateScore(userAnswer);
        }
      }

      final nmtScore = NmtScoreCalculator.calculateNMTScore(rawScore);
      final resultEntity = ExamResultEntity(
        examId: exam.id,
        examTitle: exam.title,
        rawScore: rawScore,
        nmtScore: nmtScore,
        maxRawScore: exam.maxRawScore,
        timeSpendSeconds: timeSpent,
        completedAt: DateTime.now(),
        userAnswer: next.userAnswer,
      );

      context.goNamed(AppRouters.examResultName, extra: (resultEntity, exam));
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _showExitConfirmationDialog(context);
        if (shouldExit && context.mounted) {
          controller.finishExam();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(examState.exam?.title ?? AppStrings.nmtExamen),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceS,
                vertical: AppDimensions.spaceXX,
              ),
              margin: const EdgeInsets.only(right: AppDimensions.spaceM),
              decoration: BoxDecoration(
                color: examState.timeRemainingSeconds < 300
                    ? AppColors.error
                    : AppColors.successShadow,
                borderRadius: BorderRadius.circular(AppDimensions.spaceM),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: AppDimensions.spaceML,
                    color: examState.timeRemainingSeconds < 300
                        ? AppColors.error
                        : AppColors.lightSurface,
                  ),
                  const SizedBox(width: AppDimensions.spaceXXS),
                  Text(
                    _formatTime(examState.timeRemainingSeconds),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: examState.timeRemainingSeconds < 300
                          ? AppColors.error
                          : AppColors.lightSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // 1. Верхня сітка навігації по 45 питаннях
            Container(
              height: AppDimensions.spaceXXXM,
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spaceXS,
              ),
              color: AppColors.successShadow,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceXS,
                ),
                itemCount: examState.totalQuestion,
                itemBuilder: (context, index) {
                  final isSelected = index == examState.currentQuestionIndex;
                  final isAnswered = examState.userAnswer.containsKey(index);
                  final isFlagged =
                      examState.userAnswer[index]?.isFlagged ?? false;

                  Color tileColor = Colors.white;
                  if (isSelected) {
                    tileColor = AppColors.primary;
                  } else if (isAnswered) {
                    tileColor = Colors.green.shade300;
                  }

                  return GestureDetector(
                    onTap: () => controller.goToQuestion(index),
                    child: Container(
                      width: AppDimensions.spaceXXL,
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceXXS,
                      ),
                      decoration: BoxDecoration(
                        color: tileColor,
                        border: Border.all(
                          color: isFlagged
                              ? AppColors.primary
                              : AppColors.darkBackground,
                          width: isFlagged ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.spaceXS,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.lightBackground
                                  : AppColors.darkBackground,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isFlagged)
                            const Positioned(
                              top: AppDimensions.spaceXXXS,
                              right: AppDimensions.spaceXXXS,
                              child: Icon(
                                Icons.bookmark,
                                size: AppDimensions.spaceS,
                                color: AppColors.streakDays,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 2. Вміст поточного питання
            Expanded(
              child: currentQuestion == null
                  ? const Center(child: Text(AppStrings.questionNull))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppDimensions.spaceM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Завдання ${examState.currentQuestionIndex + 1} з ${examState.totalQuestion}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () =>
                                    controller.toggleFlagCurrentQuestion(),
                                icon: Icon(
                                  examState
                                              .userAnswer[examState
                                                  .currentQuestionIndex]
                                              ?.isFlagged ??
                                          false
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: AppColors.streakDays,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimensions.spaceS),
                          Text(
                            currentQuestion.statement,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: AppDimensions.spaceL),
                          ExamAnswerWidget(
                            question: currentQuestion,
                            userAnswer: examState
                                .userAnswer[examState.currentQuestionIndex],
                            onSingleSelect: (optionIdx) =>
                                controller.selectSingleAnswer(optionIdx),
                            onMatchingSelect: (l, r) =>
                                controller.setMatchingAnswer(l, r),
                          ),
                        ],
                      ),
                    ),
            ),
            // 3. Нижня панель навігації
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceM),
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkBackground,
                    blurRadius: AppDimensions.spaceXXS,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: examState.currentQuestionIndex > 0
                        ? () => controller.goToQuestion(
                            examState.currentQuestionIndex - 1,
                          )
                        : null,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  ElevatedButton(
                    onPressed: () => _onFinishPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    child: Text(
                      AppStrings.exitTest,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: !examState.isLastQuestion
                        ? () => controller.goToQuestion(
                            examState.currentQuestionIndex + 1,
                          )
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
