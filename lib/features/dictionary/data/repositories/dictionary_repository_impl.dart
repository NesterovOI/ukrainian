import 'package:ukrainian/features/dictionary/data/datasources/dictionary_local_data_source.dart';
import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';
import 'package:ukrainian/features/dictionary/domain/repositories/dictionary_repositories.dart';

class DictionaryRepositoryImpl implements DictionaryRepositories {
  final DictionaryLocalDataSource localDataSource;

  DictionaryRepositoryImpl({required this.localDataSource});

  @override
  Future<List<RuleEntity>> getAllRules() async {
    return await localDataSource.getAllRules();
  }

  @override
  Future<RuleEntity> getRuleById(String id) async {
    final rules = await localDataSource.getAllRules();
    return rules.firstWhere((rule) => rule.id == id,
    orElse: () => throw Exception('Правило з id: $id не знайдено'),
    );
  }

  @override
  Future<List<RuleEntity>> getRulesByCategory(String categoryId) async {
    final rules = await localDataSource.getAllRules();
    return rules.where((rule) => rule.categoryId == categoryId).toList();
  }
  
}