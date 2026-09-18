import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/profile/data/datasources/local_storage_data_source.dart';
import 'package:ukrainian/features/profile/data/repositories/profile_settings_repository_impl.dart';
import 'package:ukrainian/features/profile/domain/repositories/profile_settings_repository.dart';
import 'package:ukrainian/features/profile/domain/usecases/export_usecases.dart';

final localStorageDataSourceProvider = Provider<LocalStorageDataSource>(
  (ref) => LocalStorageDataSource(),
);

final profileSettingsRepositoryProvider = Provider<ProfileSettingsRepository>((
  ref,
) {
  final dataSource = ref.watch(localStorageDataSourceProvider);
  return ProfileSettingsRepositoryImpl(dataSource);
});

final getSettingsUseCase = Provider<GetSettingsUseCase>((ref) {
  final repository = ref.watch(profileSettingsRepositoryProvider);
  return GetSettingsUseCase(repository);
});

final saveSettingsUseCase = Provider<SaveSettingsUseCase>((ref) {
  final repository = ref.watch(profileSettingsRepositoryProvider);
  return SaveSettingsUseCase(repository);
});
