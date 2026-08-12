import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/services/audio_service.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/home_controller.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/quiz_controller.dart';

class LessonQuizPage extends ConsumerStatefulWidget {
  final LessonEntity lesson;

  const LessonQuizPage({super.key, required this.lesson});

  @override
  ConsumerState<LessonQuizPage> createState() => _LessonQuizPageState();
}

class _LessonQuizPageState extends ConsumerState<LessonQuizPage> {
  late final AudioService _audioService;

  @override
  void initState() {
    super.initState();
    _audioService = AudioService();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizControllerProvider(widget.lesson));
    final quizNotifier = ref.read(
      quizControllerProvider(widget.lesson).notifier,
    );
    final homeState = ref.watch(homeControllerProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          child: Builder(
            builder: (context) {
              switch (quizState.step) {
                //Екран теорії
                case QuizPageStep.theory:
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: MarkdownBody(
                            data: widget.lesson.theoryMarkdown,
                            styleSheet: MarkdownStyleSheet.fromTheme(
                              Theme.of(context),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      SizedBox(
                        width: double.infinity,
                        height: AppDimensions.buttonHeight,
                        child: ElevatedButton(
                          onPressed: quizNotifier.startQuiz,
                          child: const Text(AppStrings.checkButton),
                        ),
                      ),
                    ],
                  );
                // 2.Екран питань та відповідей
                case QuizPageStep.questions:
                  final currentQ =
                      widget.lesson.question[quizState.currentQuestionIndex];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value:
                            (quizState.currentQuestionIndex + 1) /
                            widget.lesson.question.length,
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      Text(
                        '${AppStrings.questionLesson} ${quizState.currentQuestionIndex + 1} з ${widget.lesson.question.length}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Text(
                        currentQ.question,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppDimensions.spaceL),
                      Expanded(
                        child: ListView.builder(
                          itemCount: currentQ.options.length,
                          itemBuilder: (context, index) {
                            final option = currentQ.options[index];
                            final isSelected =
                                quizState.selectedOptionIndex == index;

                            Color cardColor = Theme.of(context).cardColor;
                            if (quizState.isAnswerCorrect != null) {
                              if (index == currentQ.correctOptionIndex) {
                                cardColor = AppColors.success.withValues(
                                  alpha: AppDimensions.opacityXXXS,
                                );
                              } else if (isSelected) {
                                cardColor = AppColors.error.withValues(
                                  alpha: AppDimensions.opacityXXXS,
                                );
                              }
                            } else if (isSelected) {
                              cardColor = Theme.of(
                                context,
                              ).colorScheme.primaryContainer;
                            }

                            return Card(
                              color: cardColor,
                              margin: const EdgeInsets.only(
                                bottom: AppDimensions.spaceS,
                              ),
                              child: ListTile(
                                title: Text(option),
                                onTap: () => quizNotifier.selectOption(index),
                              ),
                            );
                          },
                        ),
                      ),
                      // Пояснення при помилці / успіху
                      if (quizState.isAnswerCorrect != null)
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.spaceM),
                          margin: const EdgeInsets.only(
                            bottom: AppDimensions.spaceM,
                          ),
                          decoration: BoxDecoration(
                            color: quizState.isAnswerCorrect!
                                ? AppColors.success.withValues(
                                    alpha: AppDimensions.opacityXXXXS,
                                  )
                                : AppColors.error.withValues(
                                    alpha: AppDimensions.opacityXXXXS,
                                  ),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.spaceM,
                            ),
                          ),
                          child: Text(
                            quizState.isAnswerCorrect!
                                ? AppStrings.correctAnswers
                                : '${AppStrings.wrongAnswer} ${currentQ.explanation}',
                          ),
                        ),

                      // Кнопка Перевірки або Переходу далі
                      SizedBox(
                        width: double.infinity,
                        height: AppDimensions.buttonHeight,
                        child: ElevatedButton(
                          onPressed: quizState.selectedOptionIndex == null
                              ? null
                              : () {
                                  if (quizState.isAnswerCorrect == null) {
                                    // Перевіряємо відповідь
                                    final isCorrect = quizNotifier
                                        .answerQuestion();
                                    if (isCorrect) {
                                      _audioService.playCorrect();
                                    } else {
                                      _audioService.playWrong();
                                      // Знімаємо життя у користувача
                                      if (homeState != null &&
                                          !homeState.userProgress.isPremium) {
                                        final currentLives =
                                            homeState.userProgress.lives;
                                        if (currentLives > 0) {
                                          ref
                                              .read(
                                                homeControllerProvider.notifier,
                                              )
                                              .updateProgress(
                                                homeState.userProgress.copyWith(
                                                  lives: currentLives - 1,
                                                ),
                                              );
                                        }
                                      }
                                    }
                                  } else {
                                    // Переходимо до наступного питання
                                    final isFinished = quizNotifier
                                        .nextQuestion();
                                    if (isFinished) {
                                      _audioService.playSuccess();
                                      // Зберігаємо пройдений урок та додаємо бали
                                      if (homeState != null) {
                                        final updatedCompleted = [
                                          ...homeState
                                              .userProgress
                                              .completedLessonIds,
                                          widget.lesson.id,
                                        ];
                                        ref
                                            .read(
                                              homeControllerProvider.notifier,
                                            )
                                            .updateProgress(
                                              homeState.userProgress.copyWith(
                                                score:
                                                    homeState
                                                        .userProgress
                                                        .score +
                                                    quizState.earnedScore,
                                                completedLessonIds:
                                                    updatedCompleted,
                                              ),
                                            );
                                      }
                                    }
                                  }
                                },
                          child: Text(
                            quizState.isAnswerCorrect == null
                                ? AppStrings.checkButton
                                : AppStrings.continueButton,
                          ),
                        ),
                      ),
                    ],
                  );

                //Екран результату
                case QuizPageStep.result:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.stars_rounded,
                          size: AppDimensions.iconSizeXXL,
                          color: AppColors.streakDays,
                        ),
                        const SizedBox(height: AppDimensions.spaceM),
                        Text(
                          AppStrings.lessonFine,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppDimensions.spaceS),
                        Text(
                          '${AppStrings.lessonPoints} +${quizState.earnedScore}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppDimensions.spaceXL),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(AppStrings.nextLesson),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
