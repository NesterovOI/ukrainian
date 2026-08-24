import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/riverpod_providers_di.dart';

class FailedQuestionsBanner extends ConsumerWidget {
  final List<LessonEntity> allLessons;
  final Function(LessonEntity lesson) onStartQuiz;

  const FailedQuestionsBanner({
    super.key,
    required this.allLessons,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final failedQuestionsAsync = ref.watch(
      failedQuestionsFutureProvider(allLessons),
    );

    return failedQuestionsAsync.when(
      data: (failedLessons) {
        if (failedLessons == null) return const SizedBox.shrink();

        return Card(
          color: AppColors.error.withValues(alpha: AppDimensions.opacityXXXXS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(AppDimensions.spaceM),
            side: BorderSide(
              color: AppColors.error.withValues(
                alpha: AppDimensions.opacityXXXS,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.build_circle_outlined,
                      color: AppColors.error,
                      size: AppDimensions.spaceXXL,
                    ),
                    const SizedBox(width: AppDimensions.spaceM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.workForErrors,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${AppStrings.faindError} ${failedLessons.questions.length} ${AppStrings.weakQuestions}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => onStartQuiz(failedLessons),
                  child: Text(AppStrings.passTextButton),
                ),
              ],
            ),
          ),
        );
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
