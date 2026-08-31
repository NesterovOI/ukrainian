import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/services/purchase_service.dart';
import 'package:ukrainian/features/home_lessons/data/local/app_database.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';
import 'package:ukrainian/features/home_lessons/data/repositories/user_progress_repository_impl.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/export_usecases.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/get_user_progress_usecase.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/save_user_progress_usecase.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/user_progress_notifier.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final userProgressRepositoryProvider = Provider<UserProgressRepository>((ref) {
  return UserProgressRepositoryImpl(ref.watch(appDatabaseProvider));
});

final logAnswerUseCaseProvider = Provider<LogAnswerUseCase>((ref) {
  return LogAnswerUseCase(ref.watch(userProgressRepositoryProvider));
});

final getAnalyticsUseCaseProvider = Provider<GetAnalyticsUseCase>((ref) {
  return GetAnalyticsUseCase(ref.watch(userProgressRepositoryProvider));
});

final getFailedQuestionsUseCaseProvider = Provider<GetFailedQuestionsUseCase>((
  ref,
) {
  return GetFailedQuestionsUseCase(ref.watch(userProgressRepositoryProvider));
});

final analyticsFutureProvider =
    FutureProvider<List<SubcategoryAnalyticsEntity>>((ref) async {
      final getAnalytics = ref.watch(getAnalyticsUseCaseProvider);
      return await getAnalytics.call();
    });

final failedQuestionsFutureProvider =
    FutureProvider.family<LessonEntity?, List<LessonEntity>>((
      ref,
      allLessons,
    ) async {
      final useCase = ref.watch(getFailedQuestionsUseCaseProvider);
      return await useCase.call(allLessons);
    });

final getUserProgressUseCaseProvider = Provider<GetUserProgressUseCase>((ref) {
  return GetUserProgressUseCase(ref.watch(userProgressRepositoryProvider));
});

final saveUserProgressUseCaseProvider = Provider<SaveUserProgressUseCase>((
  ref,
) {
  return SaveUserProgressUseCase(ref.watch(userProgressRepositoryProvider));
});

final purchaseServiceProvider = Provider<IPurchaseService>((ref) {
  return MockPurchaseService();
});

final userProgressNotifierProvider =
    StateNotifierProvider<UserProgressNotifier, AsyncValue<UserProgressEntity>>(
      (ref) {
        return UserProgressNotifier(
          ref.watch(getUserProgressUseCaseProvider),
          ref.watch(saveUserProgressUseCaseProvider),
        );
      },
    );
