import 'dart:convert';
import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/features/exam/data/datasources/exam_local_data_source.dart';
import 'package:ukrainian/features/exam/domain/repositories/exam_repository.dart';
import 'package:ukrainian/core/database/app_database.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamLocalDataSource _localDataSource;
  final AppDatabase _db;

  ExamRepositoryImpl({
    required ExamLocalDataSource localDataSource,
    required AppDatabase db,
  }) : _localDataSource = localDataSource,
       _db = db;

  @override
  Future<ExamEntity> getExamById(String examId) async {
    return await _localDataSource.loadExamJson(examId);
  }

  @override
  Future<List<ExamEntity>> getAvailableExams() async {
    return await _localDataSource.loadAllExamsJson();
  }

  @override
  Future<void> saveExamResult(ExamResultEntity result) async {
    final answersMap = result.userAnswer.map(
      (key, value) => MapEntry(key.toString(), {
        'selectedOptionIndex': value.selectedOptionIndex,
        'matchingPairs': value.matchingPairs?.map(
          (k, v) => MapEntry(k.toString(), v),
        ),
        'isFlagged': value.isFlagged,
      }),
    );
    final companion = ExamResultsTableCompanion.insert(
      examId: result.examId,
      examTitle: result.examTitle,
      rawScore: result.rawScore,
      nmtScore: result.nmtScore,
      maxRawScore: result.maxRawScore,
      timeSpendSeconds: result.timeSpendSeconds,
      completedAt: result.completedAt,
      answersJson: jsonEncode(answersMap),
    );

    await _db.insertExamResult(companion);
  }

  @override
  Future<List<ExamResultEntity>> getExamHistory() async {
    final rows = await _db.getAllExamResults();

    return rows.map((row) {
      final Map<String, dynamic> rawAnswers =
          jsonEncode(row.answersJson) as Map<String, dynamic>;

      final userAnswers = rawAnswers.map((key, value) {
        final valMap = value as Map<String, dynamic>;
        Map<int, int>? matchingPairs;
        if (valMap['matchingPairs'] != null) {
          final rawPairs = valMap['matchingPairs'] as Map<String, dynamic>;
          matchingPairs = rawPairs.map(
            (k, v) => MapEntry(int.parse(k), v as int),
          );
        }

        return MapEntry(
          int.parse(key),
          QuestionAnswer(
            selectedOptionIndex: valMap['selectedOptionIndex'] as int?,
            matchingPairs: matchingPairs,
            isFlagged: valMap['isFlagged'] as bool? ?? false,
          ),
        );
      });

      return ExamResultEntity(
        examId: row.examId,
        examTitle: row.examTitle,
        rawScore: row.rawScore,
        nmtScore: row.nmtScore,
        maxRawScore: row.maxRawScore,
        timeSpendSeconds: row.timeSpendSeconds,
        completedAt: row.completedAt,
        userAnswer: userAnswers,
      );
    }).toList();
  }
}
