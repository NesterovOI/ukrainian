import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/presentation/pages/lesson_quiz_page.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/home_controller.dart';
import 'package:ukrainian/features/home_lessons/presentation/widgets/widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeStateAsync = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        centerTitle: true,
      ),
      body: homeStateAsync.when(
          data: (homeState) {
            final progress = homeState.userProgress;
            final lessons = homeState.lessons;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.spaceM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeaderWidget(progress: progress),
                  const SizedBox(height: AppDimensions.spaceM,),
                  QuoteCardWidget(
                      quote: homeState.quote,
                      onRefresh: () {
                        ref.read(homeControllerProvider.notifier).refreshQuote();
                      },
                  ),
                  const SizedBox(height: AppDimensions.spaceL,),
                  Text(
                    AppStrings.lessonProgram,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppDimensions.spaceS,),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        final lesson = lessons[index];
                        final isCompleted = progress.completedLessonIds.contains(lesson.id);
                        final isPreviousCompleted = index == 0 || progress.completedLessonIds.contains(lessons[index-1].id);

                        final isLocked = !progress.isPremium && (!lesson.isFree || !isPreviousCompleted);
                        return LessonCartWidget(
                            lesson: lesson,
                            isLocked: isLocked,
                            isCompleted: isCompleted,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LessonQuizPage(lesson: lesson),
                                  ),
                              );
                            }
                        );
                      },
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(),),
          error: (err, stack) => Center(
            child: Text('${AppStrings.errorDownloadDictionary} $err'),
          ),
      ),
    );
  }
}
