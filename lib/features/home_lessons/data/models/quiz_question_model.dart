import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class QuizQuestionModel extends QuizQuestionEntity {
  const QuizQuestionModel({
    required super.id,
    required super.question,
    required super.options,
    required super.correctOptionIndex,
    required super.explanation,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json){
    return QuizQuestionModel(
        id: json['id'] as String? ?? '',
        question: json['question'] as String? ?? '',
        options: (json['options'] as List<dynamic>?)?.map((e) => e.toString())
        .toList() ?? const [],
        correctOptionIndex: json['correctOptionIndex'] as int? ?? 0,
        explanation: json['explanation'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
    };
  }
}