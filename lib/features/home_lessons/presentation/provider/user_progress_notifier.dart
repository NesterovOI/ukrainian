import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/save_user_progress_usecase.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/get_user_progress_usecase.dart';
import 'package:ukrainian/core/services/purchase_service.dart';

class UserProgressNotifier
    extends StateNotifier<AsyncValue<UserProgressEntity>> {
  final GetUserProgressUseCase _getUserProgressUseCase;
  final SaveUserProgressUseCase _saveUserProgressUseCase;
  final IPurchaseService _purchaseService;

  UserProgressNotifier(
    this._getUserProgressUseCase,
    this._saveUserProgressUseCase,
    this._purchaseService,
  ) : super(const AsyncValue.loading()) {
    loadProgress();
  }

  Future<void> loadProgress() async {
    try {
      var progress = await _getUserProgressUseCase.call();
      final hasActiveSubscription = await _purchaseService
          .checkSubscriptionStatus();

      if (hasActiveSubscription && !progress.isPremium) {
        progress = progress.copyWith(
          isPremium: true,
          lives: progress.maxLives,
          lastActiveDate: DateTime.now(),
        );
        await _saveUserProgressUseCase.call(progress);
      }

      // Логіка відновлення життів за таймером
      if (!progress.isPremium && progress.lastActiveDate != null) {
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
      lives: isPremium ? current.maxLives : current.lives,
      lastActiveDate: DateTime.now(),
    );

    state = AsyncValue.data(progress);
    try {
      await _saveUserProgressUseCase.call(progress);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateUserName(String name) async {
    final current = state.value;
    if (current == null) return;

    final progress = current.copyWith(
      userName: name,
      lastActiveDate: DateTime.now(),
    );

    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  Future<void> updateAvatar(String avatarPath) async {
    final current = state.value;
    if (current == null) return;

    final progress = current.copyWith(
      avatarPath: avatarPath,
      lastActiveDate: DateTime.now(),
    );

    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  // Метод купівлі підписки
  Future<bool> buySubscription() async {
    final success = await _purchaseService.buySubscription();
    if (success) {
      await updatePremiumStatus(true);
    }
    return success;
  }

  // Метод відновлення підписок
  Future<void> restorePurchases() async {
    await _purchaseService.restorePurchases();
    final hasActiveSubscription = await _purchaseService
        .checkSubscriptionStatus();
    await updatePremiumStatus(hasActiveSubscription);
  }
}
