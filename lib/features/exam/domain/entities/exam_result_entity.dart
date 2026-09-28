import 'package:ukrainian/features/exam/domain/entities/exam_question_entity.dart';

/// Модель результату складання екзамену для Domain шару
class ExamResultEntity {
  final int? id;
  final String examId;
  final String examTitle;
  final int rawScore;
  final int nmtScore;
  final int maxRawScore;
  final int timeSpendSeconds;
  final DateTime completedAt;
  final Map<int, QuestionAnswer> userAnswer;

  const ExamResultEntity({
    this.id,
    required this.examId,
    required this.examTitle,
    required this.rawScore,
    required this.nmtScore,
    required this.maxRawScore,
    required this.timeSpendSeconds,
    required this.completedAt,
    required this.userAnswer,
  });
}
