import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/features/exam/data/datasources/exam_local_data_source.dart';
import 'package:ukrainian/features/exam/domain/repositories/exam_repository.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamLocalDataSource _localDataSource;

  ExamRepositoryImpl({required ExamLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<ExamEntity> getExamById(String examId) async {
    return await _localDataSource.loadExamJson(examId);
  }

  @override
  Future<List<ExamEntity>> getAvailableExams() async {
    return await _localDataSource.loadAllExamsJson();
  }

  @override
  Future<List<ExamResultEntity>> getExamHistory() async {
    return [];
  }

  @override
  Future<void> saveExamResult(ExamResultEntity result) {
    // TODO: implement saveExamResult
    throw UnimplementedError();
  }
}
