import 'package:ukrainian/features/home_lessons/data/datasources/home_local_data_sources.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});
  
  @override
  Future<List<LessonEntity>> getLessons() => localDataSource.getLessons();

  @override
  Future<List<QuoteEntity>> getQuotes() => localDataSource.getQuotes();

  @override
  Future<QuoteEntity> getRandomQuote() => localDataSource.getRandomQuote();

  @override
  Future<UserProgressEntity> getUserProgress() => localDataSource.getUserProgress();

  @override
  Future<void> updateUserProgress(UserProgressEntity progress) => localDataSource.saveUserProgress(progress);
  
}