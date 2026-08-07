import 'package:ukrainian/features/home_lessons/domain/entities/entities_home_export.dart';

abstract class HomeRepository {
  Future<UserProgressEntity> getUserProgress();
  Future<void> updateUserProgress(UserProgressEntity progress);
  Future<List<QuoteEntity>> getQuotes();
  Future<QuoteEntity> getRandomQuote();
  Future<List<LessonEntity>> getLessons();
}