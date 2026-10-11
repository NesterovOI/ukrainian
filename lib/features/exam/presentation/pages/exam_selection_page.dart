import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/exam/presentation/providers/exam_providers.dart';

class ExamSelectionPage extends ConsumerWidget {
  const ExamSelectionPage({super.key});

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(examHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.examPreparation)),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: AppDimensions.spaceXXS,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                side: BorderSide(color: AppColors.primary, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.examOptions,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceXXS),
                    const Text(AppStrings.examDetails),
                    const SizedBox(height: AppDimensions.spaceM),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.push(
                            AppRouters.examPagePath,
                            extra: 'nmt_2024_demo',
                          );
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(AppStrings.examStart),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spaceM),
            Text(
              AppStrings.examHistory,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.spaceS),

            // Список попередніх спроб
            Expanded(
              child: historyAsync.when(
                data: (history) {
                  if (history.isEmpty) {
                    return Center(child: const Text(AppStrings.examNotTest));
                  }
                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final item = history[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: AppDimensions.spaceXXS,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: item.nmtScore >= 100
                                ? AppColors.primary.withValues(alpha: 0.2)
                                : AppColors.error.withValues(alpha: 0.2),
                            child: Text(
                              '${item.nmtScore}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: item.nmtScore >= 100
                                        ? AppColors.primary
                                        : AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          title: Text(item.examTitle),
                          subtitle: Text(
                            AppStrings.examData + _formatDate(item.completedAt),
                          ),
                          trailing: Text(
                            '${item.rawScore}/${item.maxRawScore} балів',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) =>
                    Center(child: Text('${AppStrings.errorExam} $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
