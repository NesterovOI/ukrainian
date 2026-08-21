import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class QuizQuestionModel extends QuizQuestionEntity {
  const QuizQuestionModel({
    required super.id,
    required super.questions,
    super.type,
    super.options,
    super.correctOptionIndex,
    super.leftItems,
    super.rightItems,
    super.correctPairs,
    required super.explanation,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    QuestionType type = QuestionType.multipleChoice;
    if (json['type'] == 'matching') {
      type = QuestionType.matching;
    } else if (json['type'] == 'findError') {
      type = QuestionType.findError;
    }

    Map<int, int>? pairs;
    if (json['correctPairs'] != null) {
      final rewPairs = json['correctPairs'] as Map<String, dynamic>;
      pairs = rewPairs.map(
            (key, value) => MapEntry(int.parse(key), value as int),
      );
    }

    return QuizQuestionModel(
      id: json['id'] as String? ?? '',
      // Зчитаємо текст питання з json['question']
      questions: json['question'] as String? ?? json['questions'] as String? ?? '',
      type: type,
      options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
      correctOptionIndex: json['correctOptionIndex'] as int?,
      leftItems: (json['leftItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      // ДОДАНО знак '?' після List<dynamic>
      rightItems: (json['rightItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctPairs: pairs,
      explanation: json['explanation'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': questions,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
    };
  }
}