import 'export_entities.dart';

class LessonEntity {
  final String id;
  final String categoryTitle;
  final String title;
  final String description;
  final int order;
  final bool isFree;
  final String theoryMarkdown;
  final List<QuizQuestionEntity> questions;

  const LessonEntity({
    required this.id,
    this.categoryTitle = '',
    required this.title,
    required this.description,
    required this.order,
    required this.isFree,
    required this.theoryMarkdown,
    required this.questions,
  });
}
