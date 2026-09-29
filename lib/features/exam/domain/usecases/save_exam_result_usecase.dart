import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/features/exam/domain/repositories/exam_repository.dart';

class SaveExamResultUseCase {
  final ExamRepository _repository;
  SaveExamResultUseCase(this._repository);

  Future<void> call(ExamResultEntity result) async {
    _repository.saveExamResult(result);
  }
}
