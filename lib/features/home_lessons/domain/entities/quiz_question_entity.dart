enum QuestionType {
  multipleChoice,
  findError,
  matching,
}

class QuizQuestionEntity {
  final String id;
  final String questions;
  final QuestionType type;
  final List<String> options;
  final int? correctOptionIndex;
  final List<String>? leftItems;
  final List<String>? rightItems;
  final Map<int, int>? correctPairs;
  final String explanation;

  const QuizQuestionEntity({
    required this.id,
    required this.questions,
    this.type = QuestionType.multipleChoice,
    this.options = const [],
    this.correctOptionIndex,
    this.leftItems,
    this.rightItems,
    this.correctPairs,
    required this.explanation,
  });
}