import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';
import 'package:ukrainian/features/dictionary/domain/usecases/search_rules_usecase.dart';
import 'package:ukrainian/features/dictionary/presentation/providers/dictionary_providers.dart';

final searchRulesUseCasesProvider = Provider<SearchRulesUseCase>((ref) {
  final repo = ref.watch(dictionaryRepositoryProvider);
  return SearchRulesUseCase(repo);
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');

final searchQueryProvider = StateProvider<String>((ref) => '');

class DictionaryController extends AsyncNotifier<List<RuleEntity>> {
  @override
  Future<List<RuleEntity>> build() async {
    final query = ref.watch(searchQueryProvider);
    final category = ref.watch(selectedCategoryProvider);
    final searchUseCase = ref.watch(searchRulesUseCasesProvider);

    return searchUseCase(query: query, categoryId: category);
  }

  Future<List<RuleEntity>> _fetchRules() async {
    final repository = ref.read(dictionaryRepositoryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    if (selectedCategory == 'all') {
      return await repository.getAllRules();
    } else {
      return await repository.getRulesByCategory(selectedCategory);
    }
  }
}

final dictionaryControllerProvider =
    AsyncNotifierProvider<DictionaryController, List<RuleEntity>>(
      DictionaryController.new,
    );
