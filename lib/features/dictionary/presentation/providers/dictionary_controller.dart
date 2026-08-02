import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';
import 'package:ukrainian/features/dictionary/presentation/providers/dictionary_providers.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');

class DictionaryController extends AsyncNotifier<List<RuleEntity>> {
  @override
  FutureOr<List<RuleEntity>> build() {
    return _fetchRules();
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
