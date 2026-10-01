import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      ref.read(examControllerProvider.notifier).startExam(widget.examId);
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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

    return Scaffold(
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
                  : AppColors.success,
              borderRadius: BorderRadius.circular(AppDimensions.spaceM),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timer,
                  size: AppDimensions.spaceML,
                  color: examState.timeRemainingSeconds < 300
                      ? AppColors.error
                      : AppColors.success,
                ),
                const SizedBox(width: AppDimensions.spaceXXS),
                Text(
                  _formatTime(examState.timeRemainingSeconds),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: examState.timeRemainingSeconds < 300
                        ? AppColors.error
                        : AppColors.success,
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
                  tileColor = Colors.blue;
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
                            : AppColors.success,
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                              ),
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
                          style: Theme.of(context).textTheme.bodyMedium,
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
                ElevatedButton.icon(
                  onPressed: examState.currentQuestion > 0
                      ? () => controller.goToQuestion(
                          examState.currentQuestionIndex - 1,
                        )
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: Text(AppStrings.back),
                ),
                ElevatedButton(
                  onPressed: () => controller.finishExam(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                  ),
                  child: Text(
                    AppStrings.exitTest,
                    style: TextStyle(color: AppColors.lightBackground),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: !examState.isLastQuestion
                      ? () => controller.goToQuestion(
                          examState.currentQuestionIndex + 1,
                        )
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(AppStrings.forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
