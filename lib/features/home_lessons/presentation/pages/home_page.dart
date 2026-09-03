import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/utils/ad_helper.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/export_provider.dart';
import 'package:ukrainian/features/home_lessons/presentation/widgets/widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeStateAsync = ref.watch(homeControllerProvider);
    final userProgressAsync = ref.watch(userProgressNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle), centerTitle: true),
      body: homeStateAsync.when(
        data: (homeState) {
          final progress = userProgressAsync.value ?? homeState.userProgress;
          final lessons = homeState.lessons;
          final isPremium = progress.isPremium;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.spaceS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderWidget(
                  progress: progress,
                  onLivesTap: () {
                    RestoreLivesDialog.show(
                      context: context,
                      onWatchAd: () =>
                          showRewardedAdAndRestoreLive(context, ref),
                    );
                  },
                ),
                const SizedBox(height: AppDimensions.spaceM),
                FailedQuestionsBanner(
                  allLessons: lessons,
                  onStartQuiz: (failedLesson) {
                    if (!isPremium && progress.lives <= 0) {
                      RestoreLivesDialog.show(
                        context: context,
                        onWatchAd: () =>
                            showRewardedAdAndRestoreLive(context, ref),
                      );
                      return;
                    }

                    context.pushNamed(
                      AppRouters.lessonQuizName,
                      extra: failedLesson,
                    );
                  },
                ),

                const SizedBox(height: AppDimensions.spaceM),

                QuoteCardWidget(
                  quote: homeState.quote,
                  onRefresh: () {
                    ref.read(homeControllerProvider.notifier).refreshQuote();
                  },
                ),
                const SizedBox(height: AppDimensions.spaceL),
                Text(
                  AppStrings.lessonProgram,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppDimensions.spaceS),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index];
                    final isCompleted = progress.completedLessonIds.contains(
                      lesson.id,
                    );
                    final isLocked =
                        index != 0 &&
                        !progress.completedLessonIds.contains(
                          lessons[index - 1].id,
                        );

                    final bool showSectionHeader =
                        lesson.categoryTitle.isNotEmpty &&
                        (index == 0 ||
                            lessons[index - 1].categoryTitle !=
                                lesson.categoryTitle);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showSectionHeader) ...[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimensions.spaceL,
                              bottom: AppDimensions.spaceS,
                            ),
                            child: Text(
                              lesson.categoryTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                        LessonCartWidget(
                          lesson: lesson,
                          isLocked: isLocked,
                          isCompleted: isCompleted,
                          onTap: () {
                            if (!isPremium && progress.lives <= 0) {
                              RestoreLivesDialog.show(
                                context: context,
                                onWatchAd: () =>
                                    showRewardedAdAndRestoreLive(context, ref),
                              );
                              return;
                            }

                            context.pushNamed(
                              AppRouters.lessonQuizName,
                              extra: lesson,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('${AppStrings.errorDownloadDictionary} $err')),
      ),
    );
  }
}
