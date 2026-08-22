import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/data/local/app_database.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/user_progress_repository.dart';
import 'package:ukrainian/features/home_lessons/data/repositories/user_progress_repository_impl.dart';
import 'package:ukrainian/features/home_lessons/domain/usecases/export_usecases.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final userProgressRepositoryProvider = Provider<UserProgressRepository>((ref) {
  return UserProgressRepositoryImpl(ref.watch(appDatabaseProvider));
});

final logAnswerProvider = Provider<LogAnswerUseCase>((ref) {
  return LogAnswerUseCase(ref.watch(userProgressRepositoryProvider));
});

final getAnalyticsProvider = Provider<GetAnalyticsUseCase>((ref) {
  return GetAnalyticsUseCase(ref.watch(userProgressRepositoryProvider));
});
