class UserProgressEntity {
  final int lives;
  final int maxLives;
  final int score;
  final int streakDays;
  final bool isPremium;
  final List<String> completedLessonIds;
  final DateTime? lastActiveDate;

  const UserProgressEntity({
    required this.lives,
    this.maxLives = 5,
    required this.score,
    required this.streakDays,
    required this.isPremium,
    required this.completedLessonIds,
    this.lastActiveDate,
  });

  UserProgressEntity copyWith({
    int? lives,
    int? maxLives,
    int? score,
    int? streakDays,
    bool? isPremium,
    List<String>? completedLessonIds,
    DateTime? lastActiveDate,
  }) {
    return UserProgressEntity(
      lives: lives ?? this.lives,
      maxLives: maxLives ?? this.maxLives,
      score: score ?? this.score,
      streakDays: streakDays ?? this.streakDays,
      isPremium: isPremium ?? this.isPremium,
      completedLessonIds: completedLessonIds ?? this.completedLessonIds,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }
}
