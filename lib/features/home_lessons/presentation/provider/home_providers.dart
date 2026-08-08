import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/data/datasources/home_local_data_sources.dart';
import 'package:ukrainian/features/home_lessons/data/repositories/home_repository_impl.dart';
import 'package:ukrainian/features/home_lessons/domain/repositories/home_repository.dart';

final homeLocalDataSources = Provider<HomeLocalDataSource>(
  (ref) => HomeLocalDataSourceImpl(),
);

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final dataSource = ref.watch(homeLocalDataSources);
  return HomeRepositoryImpl(localDataSource: dataSource);
});

