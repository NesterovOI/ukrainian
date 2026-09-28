import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/core/theme/app_strings.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    required super.id,
    required super.title,
    required super.description,
    required super.timeLimitMinutes,
    required super.maxRawScore,
    required super.question,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] as String? ?? AppStrings.not_id,
      title: json['title'] as String? ?? AppStrings.not_title,
      description: json['description'] as String? ?? '',
      timeLimitMinutes: json['timeLimitMinutes'] as int? ?? 60,
      maxRawScore: json['maxRawScore'] as int? ?? 45,
      question: (json['question'] as List<dynamic>)
          .map((q) => _questionFromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }

  static ExamQuestionEntity _questionFromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String;
    final type = _parseType(typeString);

    Map<int, int>? matchingPairs;
    if (json['correctMatchingPairs'] != null) {
      final rawMap = json['correctMatchingPairs'] as Map<String, dynamic>;
      matchingPairs = rawMap.map(
        (key, value) => MapEntry(int.parse(key), value as int),
      );
    }

    return ExamQuestionEntity(
      id: json['id'] as String,
      number: json['number'] as int,
      type: type,
      statement: json['statement'] as String,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      correctOptionIndex: json['correctOptionIndex'] as int?,
      leftItems: (json['leftItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rightItems: (json['rightItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctMatchingPairs: matchingPairs,
      readingText: json['readingText'] as String?,
      explanation: json['explanation'] as String? ?? '',
    );
  }

  static ExamQuestionType _parseType(String type) {
    switch (type) {
      case 'matching':
        return ExamQuestionType.matching;
      case 'textAnalysis':
        return ExamQuestionType.textAnalysis;
      case 'singleChoice':
      default:
        return ExamQuestionType.singleChoice;
    }
  }
}
