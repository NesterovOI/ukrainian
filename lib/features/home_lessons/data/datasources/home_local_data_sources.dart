import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/data/models/export_models.dart';
import 'package:ukrainian/core/theme/theme.dart';

abstract class HomeLocalDataSource {
  Future<List<QuoteModel>> getQuotes();

  Future<QuoteModel> getRandomQuote();

  Future<List<LessonModel>> getLessons();

  Future<UserProgressEntity> getUserProgress();

  Future<void> saveUserProgress(UserProgressEntity progress);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final String quotePath;
  final String lessonPath;

  UserProgressEntity _cachedProgress = const UserProgressEntity(
    lives: 5,
    maxLives: 5,
    score: 0,
    streakDays: 1,
    isPremium: false,
    completedLessonIds: [],
  );

  HomeLocalDataSourceImpl({
    this.quotePath = AppAssets.jsonQuotes,
    this.lessonPath = AppAssets.jsonLessons,
  });

  @override
  Future<List<QuoteModel>> getQuotes() async {
    final String response = await rootBundle.loadString(quotePath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => QuoteModel.fromJson(json)).toList();
  }

  @override
  Future<QuoteModel> getRandomQuote() async {
    final quotes = await getQuotes();
    if (quotes.isEmpty) {
      return QuoteModel(
        id: AppStrings.defaultQuote,
        text: AppStrings.textDefaultQuote,
        author: AppStrings.authorDefaultQuote,
      );
    }
    final Random random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  @override
  Future<List<LessonModel>> getLessons() async {
    final String response = await rootBundle.loadString(lessonPath);
    final List<dynamic> data = json.decode(response);
    final lessons = data.map((json) => LessonModel.fromJson(json)).toList();
    lessons.sort((a, b) => a.order.compareTo(b.order));
    return lessons;
  }

  @override
  Future<UserProgressEntity> getUserProgress() async {
    return _cachedProgress;
  }

  @override
  Future<void> saveUserProgress(UserProgressEntity progress) async {
    _cachedProgress = progress;
  }
}
