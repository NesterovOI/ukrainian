import 'package:ukrainian/features/exam/domain/entities/export_exam.dart';

abstract class ExamRepository {
  /// Завантаження екзамену за його ID з JSON
  Future<ExamEntity> getExamById(String examId);

  /// Отримання списку всіх доступних варіантів НМТ
  Future<List<ExamEntity>> getAvailableExams();

  /// Збереження результату складеного екзамену в БД
  Future<void> saveExamResult(ExamResultEntity result);

  /// Отримання історії всіх пройдених екзаменів для статистики
  Future<List<ExamResultEntity>> getExamHistory();
}
