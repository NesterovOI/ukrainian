import 'package:ukrainian/features/home_lessons/data/models/quiz_question_model.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class LessonModel extends LessonEntity {
  const LessonModel({
    required super.id,
    required super.categoryTitle,
    required super.title,
    required super.description,
    required super.order,
    required super.isFree,
    required super.theoryMarkdown,
    required super.questions,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String? ?? '',
      categoryTitle: json['categoryTitle'] as String? ?? json['category_title'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      isFree: json['isFree'] as bool? ?? true,
      theoryMarkdown: json['theoryMarkdown'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
          ?.map((q) => QuizQuestionModel.fromJson(q as Map<String, dynamic>))
          .toList() ?? const [],
    );
  }
}
