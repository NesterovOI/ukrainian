import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/core/services/nmt_score_calculator.dart';

class ExamResultPage extends StatelessWidget {
  final ExamResultEntity result;
  final ExamEntity exam;

  const ExamResultPage({super.key, required this.result, required this.exam});

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isPassed = NmtScoreCalculator.isPassed(result.nmtScore);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        context.go(AppRouters.exam);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.resultExamTitle),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          child: Column(
            children: [
              // 1. картка загальних балів
              Card(
                elevation: AppDimensions.spaceXXS,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  child: Column(
                    children: [
                      Icon(
                        isPassed
                            ? Icons.emoji_events
                            : Icons.sentiment_dissatisfied,
                        size: AppDimensions.spaceXXXM,
                        color: isPassed ? AppColors.primary : AppColors.error,
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Text(
                        isPassed
                            ? AppStrings.velcomeExam
                            : AppStrings.notVelcomeExam,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isPassed ? AppColors.primary : AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      const Divider(),
                      const SizedBox(height: AppDimensions.spaceM),
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.spaceM),
                        decoration: BoxDecoration(
                          color: isPassed ? AppColors.primary : AppColors.error,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                        child: Column(
                          children: [
                            _ScoreStateTitle(
                              title: AppStrings.examScore,
                              value:
                                  '${result.rawScore} / ${result.maxRawScore}',
                            ),
                            const SizedBox(height: AppDimensions.spaceXS),
                            _ScoreStateTitle(
                              title: AppStrings.examNMT,
                              value: '${result.nmtScore} / 200',
                              highlight: true,
                            ),
                            const SizedBox(height: AppDimensions.spaceXS),
                            _ScoreStateTitle(
                              title: AppStrings.examTime,
                              value: _formatTime(result.timeSpendSeconds),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.spaceL),
              // 2. Список усіх питань із деталізацією та аналізом помилок
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.examResponseAnalysis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppDimensions.spaceS),
                itemCount: exam.question.length,
                itemBuilder: (context, index) {
                  final q = exam.question[index];
                  final userAnswer = result.userAnswer[index];
                  final earnedScore = userAnswer != null
                      ? q.calculateScore(userAnswer)
                      : 0;
                  final maxScore = q.maxScore;
                  final isFullScore = earnedScore == maxScore;
                  final isPartialScore =
                      earnedScore > 0 && earnedScore < maxScore;

                  final explanation = q.explanation;

                  Color statusColor = AppColors.error;
                  if (isFullScore) statusColor = AppColors.success;
                  if (isPartialScore) statusColor = AppColors.primaryShadow;

                  return ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: statusColor,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: statusColor),
                      ),
                    ),
                    title: Text(
                      q.statement,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Бал: $earnedScore / $maxScore',
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppDimensions.spaceM),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.examFullQuestions,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: AppDimensions.spaceXXS),
                            Text(q.statement),

                            if (explanation != null &&
                                explanation.isNotEmpty) ...[
                              const SizedBox(height: AppDimensions.spaceXXS),
                              Container(
                                padding: const EdgeInsets.all(
                                  AppDimensions.spaceS,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryShadow,
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusM,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.lightbulb_outline,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(
                                      width: AppDimensions.spaceXS,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppStrings.examExplanation +
                                            ' ' +
                                            explanation,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: AppDimensions.spaceXL),

              // 3. Кнопка повернення на головне меню
              SizedBox(
                width: double.infinity,
                height: AppDimensions.spaceXXXL,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRouters.exam);
                  },
                  child: Text(AppStrings.examFinish),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreStateTitle extends StatelessWidget {
  final String title;
  final String value;
  final bool highlight;

  const _ScoreStateTitle({
    required this.title,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppDimensions.spaceXXS),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: highlight ? AppColors.primary : null,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
