enum ExamQuestionType { singleChoice, matching, textAnalysis }

class QuestionAnswer {
  final int? selectedOptionIndex; // Для singleChoice та textAnalysis
  final Map<int, int>? matchingPairs; // Для matching: {leftIndex: rightIndex}
  final bool isFlagged; //Щоб користувач міг позначати складне питання

  const QuestionAnswer({
    this.selectedOptionIndex,
    this.matchingPairs,
    this.isFlagged = false,
  });

  QuestionAnswer copyWith({
    int? selectedOptionIndex,
    Map<int, int>? matchingPairs,
    bool? isFlagged,
  }) {
    return QuestionAnswer(
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      matchingPairs: matchingPairs ?? this.matchingPairs,
      isFlagged: isFlagged ?? this.isFlagged,
    );
  }

  bool get hasAnswer {
    if (selectedOptionIndex != null) return true;
    if (matchingPairs != null && matchingPairs!.isNotEmpty) return true;
    return false;
  }
}

class ExamQuestionEntity {
  final String id;
  final int number;
  final ExamQuestionType type;
  final String statement;
  final List<String> options;
  final int? correctOptionIndex;
  final List<String>? leftItems;
  final List<String>? rightItems;
  final Map<int, int>? correctMatchingPairs;
  final String? readingText;
  final String explanation;

  const ExamQuestionEntity({
    required this.id,
    required this.number,
    required this.type,
    required this.statement,
    this.options = const [],
    this.correctOptionIndex,
    this.leftItems,
    this.rightItems,
    this.correctMatchingPairs,
    this.readingText,
    required this.explanation,
  });

  /// Підрахунок первинного балу за це питання
  int calculateScore(QuestionAnswer? userAnswer) {
    if (userAnswer == null) return 0;

    switch (type) {
      case ExamQuestionType.singleChoice:
      case ExamQuestionType.textAnalysis:
        if (userAnswer.selectedOptionIndex == correctOptionIndex) {
          return 1;
        }
        return 0;

      case ExamQuestionType.matching:
        if (userAnswer.matchingPairs == null || correctMatchingPairs == null) {
          return 0;
        }
        int earnedScore = 0;
        userAnswer.matchingPairs!.forEach((leftIdx, rightIdx) {
          if (correctMatchingPairs![leftIdx] == rightIdx) {
            earnedScore += 1;
          }
        });
        return earnedScore;
    }
  }

  int get maxScore {
    if (type == ExamQuestionType.matching) {
      return leftItems?.length ?? 4;
    }
    return 1;
  }
}
