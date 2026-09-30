import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/database/app_database.dart';
import 'package:ukrainian/features/exam/data/datasources/exam_local_data_source.dart';
import 'package:ukrainian/features/exam/data/repositories/exam_repository_impl.dart';
import 'package:ukrainian/features/exam/domain/repositories/exam_repository.dart';
import 'package:ukrainian/features/exam/domain/usecases/export_usecase.dart';
import 'package:ukrainian/features/exam/presentation/providers/exam_controller.dart';
import 'package:ukrainian/features/exam/presentation/providers/exam_state.dart';

final examLocalDataSourceProvider = Provider<ExamLocalDataSource>(
  (ref) => ExamLocalDataSourceImpl(),
);

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final examRepositoryProvider = Provider<ExamRepository>(
  (ref) => ExamRepositoryImpl(
    localDataSource: ref.watch(examLocalDataSourceProvider),
    db: ref.watch(appDatabaseProvider),
  ),
);

final getExamUseCaseProvider = Provider<GetExamUseCase>(
  (ref) => GetExamUseCase(ref.watch(examRepositoryProvider)),
);

final saveExamResultUseCaseProvider = Provider<SaveExamResultUseCase>(
  (ref) => SaveExamResultUseCase(ref.watch(examRepositoryProvider)),
);

final examControllerProvider =
    StateNotifierProvider.autoDispose<ExamController, ExamState>(
      (ref) => ExamController(
        getExamUseCase: ref.watch(getExamUseCaseProvider),
        saveExamResultUseCase: ref.watch(saveExamResultUseCaseProvider),
      ),
    );
