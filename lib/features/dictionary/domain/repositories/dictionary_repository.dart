import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';

abstract class DictionaryRepository {
  Future<List<RuleEntity>> getAllRules();
  Future<RuleEntity> getRuleById(String id);
  Future<List<RuleEntity>> getRulesByCategory(String categoryId);
}