import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/features/exam/domain/repositories/exam_repository.dart';

class GetExamUseCase {
  final ExamRepository _repository;
  GetExamUseCase(this._repository);

  Future<ExamEntity> call(String examId) async {
    return await _repository.getExamById(examId);
  }
}
