import 'package:ukrainian/features/exam/domain/entities/exam_question_entity.dart';

class ExamEntity {
  final String id;
  final String title;
  final String description;
  final int timeLimitMinutes;
  final int maxRawScore;
  final List<ExamQuestionEntity> question;

  const ExamEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.timeLimitMinutes,
    required this.maxRawScore,
    required this.question,
  });
}
