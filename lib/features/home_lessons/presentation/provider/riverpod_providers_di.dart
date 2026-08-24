import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/data/local/app_database.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';
import 'package:ukrainian/features/home_lessons/data/repositories/user_progress_repository_impl.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/export_usecases.dart';

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
