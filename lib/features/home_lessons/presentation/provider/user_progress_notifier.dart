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
  ) : super(const AsyncValue.loading());

  Future<void> loadProgress() async {
    state = const AsyncValue.loading();
    try {
      final progress = await _getUserProgressUseCase.call();
      state = AsyncValue.data(progress);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> decreaseLife() async {
    final current = state.value;

    if (current == null || current.lives <= 0) return;
    final progress = current.copyWith(lives: current.lives - 1);
    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  Future<void> addScore(int points) async {
    final current = state.value;

    if (current == null) return;
    final progress = current.copyWith(score: current.score + points);
    state = AsyncValue.data(progress);
    await _saveUserProgressUseCase.call(progress);
  }

  Future<void> markLessonCompleted(String lessonId) async {
    final current = state.value;
    if (current == null) return;

    if (!current.completedLessonIds.contains(lessonId)) {
      final updatedList = List<String>.from(current.completedLessonIds)
        ..add(lessonId);
      final progress = current.copyWith(completedLessonIds: updatedList);

      state = AsyncValue.data(progress);
      await _saveUserProgressUseCase.call(progress);
    }
  }
}
