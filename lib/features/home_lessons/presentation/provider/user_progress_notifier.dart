import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/save_user_progress_usecase.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/get_user_progress_usecase.dart';

class UserProgressNotifier
    extends StateNotifier<AsyncValue<UserProgressEntity>> {
  final GetUserProgressUseCase _getUserProgressUseCase;
  final SaveUserProgressUseCase _saveUserProgressUseCase;

  UserProgressNotifier(
    this._getUserProgressUseCase,
    this._saveUserProgressUseCase,
  ) : super(const AsyncValue.loading()) {
    loadProgress();
  }

  Future<void> loadProgress() async {
    try {
      var progress = await _getUserProgressUseCase.call();
      // Логіка відновлення життів за таймером
      if (progress.lastActiveDate != null) {
        final hoursDifference = DateTime.now()
            .difference(progress.lastActiveDate!)
            .inHours;

        if (hoursDifference >= 24 && progress.lives < progress.maxLives) {
          progress = progress.copyWith(
            lives: progress.maxLives,
            lastActiveDate: DateTime.now(),
          );
          await _saveUserProgressUseCase.call(progress);
        }
      }
      state = AsyncValue.data(progress);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> decreaseLife() async {
    final current = state.value;

    if (current == null || current.isPremium || current.lives <= 0) return;

    final progress = current.copyWith(
      lives: current.lives - 1,
      lastActiveDate: DateTime.now(),
    );
    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  Future<void> addScore(int points) async {
    final current = state.value;

    if (current == null) return;
    final progress = current.copyWith(
      score: current.score + points,
      lastActiveDate: DateTime.now(),
    );
    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  Future<void> addLife() async {
    final current = state.value;
    if (current == null) return;

    if (current.lives >= current.maxLives) return;

    final updatesLives = (current.lives + 1).clamp(0, current.maxLives);

    final progress = current.copyWith(
      lives: updatesLives,
      lastActiveDate: DateTime.now(),
    );
    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  Future<void> markLessonCompleted(String lessonId) async {
    final current = state.value;
    if (current == null) return;

    if (!current.completedLessonIds.contains(lessonId)) {
      final updatedLessons = List<String>.from(current.completedLessonIds)
        ..add(lessonId);
      final progress = current.copyWith(
        completedLessonIds: updatedLessons,
        lastActiveDate: DateTime.now(),
      );

      state = AsyncValue.data(progress);
      await _saveUserProgressUseCase.call(progress);
    }
  }

  Future<void> restoreLifeFromAd() async {
    final current = state.value;
    if (current == null) return;

    if (current.lives >= current.maxLives) return;

    final updatedLives = (current.lives + 1).clamp(0, current.maxLives);

    final progress = current.copyWith(
      lives: updatedLives,
      lastActiveDate: DateTime.now(),
    );

    state = AsyncValue.data(progress);

    try {
      await _saveUserProgressUseCase.call(progress);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updatePremiumStatus(bool isPremium) async {
    final current = state.value;
    if (current == null) return;

    final progress = current.copyWith(
      isPremium: isPremium,
      lastActiveDate: DateTime.now(),
    );

    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }
}
