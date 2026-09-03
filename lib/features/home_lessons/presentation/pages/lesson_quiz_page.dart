import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:ukrainian/core/services/service.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/export_provider.dart';
import 'package:ukrainian/features/home_lessons/presentation/widgets/widgets.dart';
import 'package:ukrainian/core/utils/ad_helper.dart';

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

  void _showOutOfLivesModel() {
    RestoreLivesDialog.show(
      context: context,
      onWatchAd: () async {
        final success = await showRewardedAdAndRestoreLive(context, ref);
        if (!success && mounted) {
          context.pop();
        }
      },
      onCancel: () {
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizControllerProvider(widget.lesson));
    final quizNotifier = ref.read(
      quizControllerProvider(widget.lesson).notifier,
    );

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
                      quizState.activeQuestions[quizState.currentQuestionIndex];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value:
                            (quizState.currentQuestionIndex + 1) /
                            quizState.activeQuestions.length,
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      Text(
                        '${AppStrings.questionLesson} ${quizState.currentQuestionIndex + 1} з ${quizState.activeQuestions.length}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Text(
                        currentQ.questions,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      Expanded(
                        child: currentQ.type == QuestionType.matching
                            ? _buildMatchingView(
                                currentQ,
                                quizState,
                                quizNotifier,
                              )
                            : _buildOptionsView(
                                currentQ,
                                quizState,
                                quizNotifier,
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
                          onPressed: _isButtonEnabled(currentQ, quizState)
                              ? () async {
                                  if (quizState.isAnswerCorrect == null) {
                                    // Перевіряємо відповідь
                                    final isCorrect = quizNotifier
                                        .answerQuestion();
                                    if (isCorrect) {
                                      _audioService.playCorrect();
                                    } else {
                                      _audioService.playWrong();
                                      await ref
                                          .read(
                                            userProgressNotifierProvider
                                                .notifier,
                                          )
                                          .decreaseLife();
                                      // Перевіряємо чи незакінчилися життя
                                      final currentLives =
                                          ref
                                              .read(
                                                userProgressNotifierProvider,
                                              )
                                              .value
                                              ?.lives ??
                                          0;
                                      if (currentLives <= 0) {
                                        _showOutOfLivesModel();
                                      }
                                    }
                                  } else {
                                    // Переходимо далі (QuizController САМ зберігає виключно завершений урок)
                                    final isFinished = quizNotifier
                                        .nextQuestion();
                                    if (isFinished) {
                                      _audioService.playSuccess();
                                    }
                                  }
                                }
                              : null,
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
                        Lottie.asset(
                          AppAssets.animationCelebrationCat,
                          width: 200,
                          height: 200,
                          repeat: true,
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
                          onPressed: () async {
                            _audioService.playClick();
                            context.pop();
                          },
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

// Віджет для звичайного вибору / вибору помилки
Widget _buildOptionsView(
  QuizQuestionEntity question,
  QuizState state,
  QuizController notifier,
) {
  return ListView.builder(
    itemCount: question.options.length,
    itemBuilder: (context, index) {
      final option = question.options[index];
      final isSelected = state.selectedOptionIndex == index;

      Color cardColor = Theme.of(context).cardColor;
      if (state.isAnswerCorrect != null) {
        if (index == question.correctOptionIndex) {
          cardColor = AppColors.success.withValues(
            alpha: AppDimensions.opacityXXXS,
          );
        } else if (isSelected) {
          cardColor = AppColors.error.withValues(
            alpha: AppDimensions.opacityXXXS,
          );
        }
      } else if (isSelected) {
        cardColor = Theme.of(context).colorScheme.primaryContainer;
      }
      return Card(
        color: cardColor,
        margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
        child: ListTile(
          title: Text(option),
          onTap: () => notifier.selectOption(index),
        ),
      );
    },
  );
}

// Віджет для завдань НА ВІДПОВІДНОСТІ (Matching)
Widget _buildMatchingView(
  QuizQuestionEntity question,
  QuizState state,
  QuizController notifier,
) {
  final lefts = question.leftItems ?? [];
  final rights = question.rightItems ?? [];
  return Row(
    children: [
      // Ліва колонка
      Expanded(
        child: ListView.builder(
          itemCount: lefts.length,
          itemBuilder: (context, index) {
            final isSelected = state.activeLeftMatchingIndex == index;
            final isPaired = state.selectedMatchingPairs.containsKey(index);

            return Card(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : isPaired
                  ? AppColors.success.withValues(
                      alpha: AppDimensions.opacityXXXXS,
                    )
                  : Theme.of(context).cardColor,
              child: ListTile(
                dense: true,
                title: Text(
                  lefts[index],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () => notifier.selectedMatchingLeft(index),
              ),
            );
          },
        ),
      ),
      const SizedBox(width: AppDimensions.spaceXS),
      // Права колонка
      Expanded(
        child: ListView.builder(
          itemCount: rights.length,
          itemBuilder: (context, index) {
            final isPaired = state.selectedMatchingPairs.containsValue(index);

            return Card(
              color: isPaired
                  ? AppColors.success.withValues(
                      alpha: AppDimensions.opacityXXXXS,
                    )
                  : Theme.of(context).cardColor,
              child: ListTile(
                dense: true,
                title: Text(
                  rights[index],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () => notifier.selectedMatchingRight(index),
              ),
            );
          },
        ),
      ),
    ],
  );
}

bool _isButtonEnabled(QuizQuestionEntity question, QuizState state) {
  if (state.isAnswerCorrect != null) return true;
  if (question.type == QuestionType.matching) {
    return state.selectedMatchingPairs.length ==
        (question.leftItems?.length ?? 0);
  }
  return state.selectedOptionIndex != null;
}
