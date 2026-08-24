import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:ukrainian/features/home_lessons/data/local/app_database.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class UserProgressRepositoryImpl implements UserProgressRepository {
  final AppDatabase _db;

  UserProgressRepositoryImpl(this._db);

  @override
  Future<void> logAnswer({
    required String lessonId,
    required String subcategory,
    required String questionId,
    required bool isCorrect,
  }) async {
    await _db
        .into(_db.questionHistoryTable)
        .insert(
          QuestionHistoryTableCompanion.insert(
            lessonId: lessonId,
            subcategoryId: subcategory,
            questionId: questionId,
            isCorrect: isCorrect,
            answeredAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<List<SubcategoryAnalyticsEntity>> getSubcategoryAnalytics() async {
    final rows = await _db.select(_db.questionHistoryTable).get();
    final Map<String, List<bool>> grouped = {};
    for (final row in rows) {
      grouped.putIfAbsent(row.subcategoryId, () => []).add(row.isCorrect);
    }
    return grouped.entries.map((entry) {
      final total = entry.value.length;
      final correct = entry.value.where((isCorrect) => isCorrect).length;
      return SubcategoryAnalyticsEntity(
        subcategoryId: entry.key,
        totalAttems: total,
        accuratePercentage: (correct / total) * 100,
      );
    }).toList();
  }

  @override
  Future<UserProgressEntity> getUserProgress() async {
    final data = await _db.getUserProgress();
    final List<dynamic> rawList = jsonDecode(data.completedLessonIds);
    final completedIds = rawList.map((e) => e.toString()).toList();

    return UserProgressEntity(
      lives: data.lives,
      score: data.score,
      streakDays: 0,
      isPremium: false,
      completedLessonIds: completedIds,
    );
  }

  @override
  Future<void> saveUserProgress(UserProgressEntity progress) async {
    await _db.updateUserProgress(
      UserProgressTableCompanion(
        lives: Value(progress.lives),
        score: Value(progress.score),
        completedLessonIds: Value(jsonEncode(progress.completedLessonIds)),
        lastActiveDate: Value(DateTime.now()),
      ),
    );
  }
}
