import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/dictionary/data/datasources/dictionary_local_data_source.dart';
import 'package:ukrainian/features/dictionary/data/repositories/dictionary_repository_impl.dart';
import 'package:ukrainian/features/dictionary/domain/repositories/dictionary_repository.dart';

final dictionaryLocalDataSourceProvider = Provider<DictionaryLocalDataSource>(
  (ref) => DictionaryLocalDataSourceImpl(),
);

final dictionaryRepositoryProvider = Provider<DictionaryRepository>((ref) {
  final localDataSource = ref.watch(dictionaryLocalDataSourceProvider);
  return DictionaryRepositoryImpl(localDataSource: localDataSource);
});
