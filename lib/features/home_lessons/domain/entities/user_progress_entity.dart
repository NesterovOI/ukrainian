import 'package:flutter/foundation.dart';
import 'package:ukrainian/core/theme/theme.dart';

class UserProgressEntity {
  final String userName;
  final String? avatarPath;
  final int lives;
  final int maxLives;
  final int score;
  final int streakDays;
  final bool isPremium;
  final List<String> completedLessonIds;
  final DateTime? lastActiveDate;

  const UserProgressEntity({
    this.userName = AppStrings.student,
    this.avatarPath,
    required this.lives,
    this.maxLives = 5,
    required this.score,
    required this.streakDays,
    required this.isPremium,
    required this.completedLessonIds,
    this.lastActiveDate,
  });

  UserProgressEntity copyWith({
    String? userName,
    String? avatarPath,
    int? lives,
    int? maxLives,
    int? score,
    int? streakDays,
    bool? isPremium,
    List<String>? completedLessonIds,
    DateTime? lastActiveDate,
  }) {
    return UserProgressEntity(
      userName: userName ?? this.userName,
      avatarPath: avatarPath ?? this.avatarPath,
      lives: lives ?? this.lives,
      maxLives: maxLives ?? this.maxLives,
      score: score ?? this.score,
      streakDays: streakDays ?? this.streakDays,
      isPremium: isPremium ?? this.isPremium,
      completedLessonIds: completedLessonIds ?? this.completedLessonIds,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressEntity &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          avatarPath == other.avatarPath &&
          lives == other.lives &&
          maxLives == other.maxLives &&
          score == other.score &&
          streakDays == other.streakDays &&
          isPremium == other.isPremium &&
          listEquals(completedLessonIds, other.completedLessonIds);

  @override
  int get hashCode =>
      userName.hashCode ^
      avatarPath.hashCode ^
      lives.hashCode ^
      maxLives.hashCode ^
      score.hashCode ^
      streakDays.hashCode ^
      isPremium.hashCode ^
      Object.hashAll(completedLessonIds);

  int get displayLives => isPremium ? 999 : lives;
}
