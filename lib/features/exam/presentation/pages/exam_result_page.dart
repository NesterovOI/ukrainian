import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.resultExamTitle),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(children: [

          ],
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
