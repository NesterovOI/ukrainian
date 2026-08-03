import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';
import 'package:ukrainian/features/dictionary/domain/repositories/dictionary_repository.dart';

class SearchRulesUseCase {
  DictionaryRepository repository;

  SearchRulesUseCase(this.repository);

  Future<List<RuleEntity>> call({
    required String query,
    required String categoryId,
  }) async {
    final rules = categoryId == 'all'
        ? await repository.getAllRules()
        : await repository.getRulesByCategory(categoryId);

    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      return rules;
    }

    return rules.where((rule) {
      final matchesTitle = rule.title.toLowerCase().contains(cleanQuery);
      final matchesSummary = rule.summary.toLowerCase().contains(cleanQuery);
      final matchesExamples = rule.examples.any(
        (ex) => ex.toLowerCase().contains(cleanQuery),
      );
      return matchesTitle || matchesSummary || matchesExamples;
    }).toList();
  }
}
