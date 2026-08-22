import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/riverpod_providers_di.dart';

class AnalyticsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.titleAppBarAnaluticsPage),
        centerTitle: true,
      ),
      body: analyticsAsync.when(
        data: ((data) {
          if (data.isEmpty) {
            return Center(
              child: Text(
                AppStrings.testAnalyticsPage,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            );
          }

          // Сорюю: спочатку найслабші теми (найнижчий відсоток)
          final sortedData = List<SubcategoryAnalyticsEntity>.from(data)
            ..sort(
              (a, b) => a.accuratePercentage.compareTo(b.accuratePercentage),
            );

          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            itemCount: sortedData.length,
            itemBuilder: (context, index) {
              final item = sortedData[index];
              final acuracy = item.accuratePercentage.round();

              Color statusColor;
              String statusText;

              if (acuracy < 50) {
                statusColor = AppColors.error;
                statusText = AppStrings.bagAnalyticsPage;
              } else if (acuracy < 80) {
                statusColor = AppColors.primaryShadow;
                statusText = AppStrings.normalAnalyticsPage;
              } else {
                statusColor = AppColors.success;
                statusText = AppStrings.goodAnalyticsPage;
              }

              return Card(
                margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.subcategoryId,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.spaceS,
                              vertical: AppDimensions.spaceXXS,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(
                                alpha: AppDimensions.opacityXXS,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusXS,
                              ),
                            ),
                            child: Text(
                              '$acuracy%',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: statusColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        'Спробовано: ${item.totalAttems} разів. $statusText',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXXS,
                        ),
                        child: LinearProgressIndicator(
                          value: item.accuratePercentage / 100,
                          color: statusColor,
                          backgroundColor: statusColor.withValues(
                            alpha: AppDimensions.opacityXXXXS,
                          ),
                          minHeight: AppDimensions.spaceXX,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(AppStrings.errorAnalyticsPage + error.toString()),
        ),
      ),
    );
  }
}
