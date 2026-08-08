import 'export_entities.dart';

class LessonEntity {
  final String id;
  final String title;
  final String description;
  final int order;
  final bool isFree;
  final String theoryMarkdown;
  final List<QuizQuestionEntity> question;

  const LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.isFree,
    required this.theoryMarkdown,
    required this.question,
  });
}
