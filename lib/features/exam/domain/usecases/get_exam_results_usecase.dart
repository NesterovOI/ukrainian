import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';
import 'package:ukrainian/features/exam/domain/repositories/exam_repository.dart';

class GetExamResultsUseCase {
  final ExamRepository _examRepository;

  GetExamResultsUseCase(this._examRepository);

  Future<List<ExamResultEntity>> call() async {
    return await _examRepository.getExamHistory();
  }
}
