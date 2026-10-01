import 'package:flutter/material.dart';
import 'package:ukrainian/features/exam/domain/entities/exam_question_entity.dart';
import 'package:ukrainian/core/theme/theme.dart';

class ExamAnswerWidget extends StatelessWidget {
  final ExamQuestionEntity question;
  final QuestionAnswer? userAnswer;
  final Function(int) onSingleSelect;
  final Function(int left, int right) onMatchingSelect;

  const ExamAnswerWidget({
    super.key,
    required this.question,
    required this.userAnswer,
    required this.onSingleSelect,
    required this.onMatchingSelect,
  });

  @override
  Widget build(BuildContext context) {
    final readingText = question.readingText;
    final leftItems = question.leftItems;
    final rightItems = question.rightItems;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Якщо це завдання до тексту (textAnalysis) і текст присутній
        if (question.type == ExamQuestionType.textAnalysis &&
            readingText != null &&
            readingText.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceS),
            margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
            decoration: BoxDecoration(
              color: AppColors.disabledShadow,
              borderRadius: BorderRadius.circular(AppDimensions.spaceS),
              border: Border.all(color: AppColors.disabled),
            ),
            child: Text(
              readingText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],

        // 1. Одиночний вибір (singleChoice) або Аналіз тексту (textAnalysis)
        if (question.type == ExamQuestionType.singleChoice ||
            question.type == ExamQuestionType.textAnalysis) ...[
          ...List.generate(question.options.length, (index) {
            final isSelected = userAnswer?.selectedOptionIndex == index;
            return Card(
              color: isSelected ? AppColors.primary : null,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isSelected
                      ? AppColors.streakDays
                      : AppColors.disabledShadow,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.spaceS),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: AppDimensions.spaceXX,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSelected
                      ? AppColors.primaryShadow
                      : AppColors.disabled,
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.lightSurface
                          : AppColors.darkBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(question.options[index]),
                onTap: () => onSingleSelect(index),
              ),
            );
          }),
        ],

        // 2. Установлення відповідності (matching)
        if (question.type == ExamQuestionType.matching) ...[
          Text(AppStrings.match, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppDimensions.spaceS),

          // Виводимо ліву колонку (1, 2, 3, 4) та вибір з правої (А, Б, В, Г, Д)
          if (leftItems != null && rightItems != null) ...[
            // Спочатку виводимо список елементів для орієнтиру
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceS),
              margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppDimensions.spaceS),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...leftItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.spaceXXXS,
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const Divider(height: AppDimensions.spaceM),

                  ...rightItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.spaceXXXS,
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(color: AppColors.darkBackground),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Сітка вибору відповідностей
            ...List.generate(leftItems.length, (leftIdx) {
              final selectedPairs = userAnswer?.matchingPairs ?? {};
              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
                child: Row(
                  children: [
                    Text(
                      '${leftIdx + 1}: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: AppDimensions.spaceXS),
                    Expanded(
                      child: Wrap(
                        spacing: AppDimensions.spaceXS,
                        children: List.generate(rightItems.length, (rightIdx) {
                          final isSelected = selectedPairs[leftIdx] == rightIdx;
                          return ChoiceChip(
                            label: Text(String.fromCharCode(1040 + rightIdx)),
                            selected: isSelected,
                            onSelected: (_) =>
                                onMatchingSelect(leftIdx, rightIdx),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ],
    );
  }
}
