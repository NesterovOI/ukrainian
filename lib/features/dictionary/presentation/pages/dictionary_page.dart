import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/core/widgets/custom_text_from_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/dictionary/presentation/providers/dictionary_controller.dart';
import 'package:ukrainian/features/dictionary/presentation/widgets/rule_card.dart';

class DictionaryPage extends ConsumerStatefulWidget {
  const DictionaryPage({super.key});

  @override
  ConsumerState<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends ConsumerState<DictionaryPage> {
  late final TextEditingController _searchController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  static const categories = [
    {'id': 'all', 'name': 'Всі правила'},
    {'id': 'phonetics', 'name': 'Фонетика'},
    {'id': 'grafika', 'name': 'Графіка'},
    {'id': 'orfoepia', 'name': 'Орфоепія'},
    {'id': 'orthography', 'name': 'Орфографія'},
    {'id': 'lexicology', 'name': 'Лексикологія'},
    {'id': 'phraseology', 'name': 'Фразеологія'},
    {'id': 'morphemics_word_building', 'name': 'Будова слова і словотвір'},
    {'id': 'morphology', 'name': 'Морфологія'},
    {'id': 'syntax', 'name': 'Синтаксис'},
    {'id': 'punctuation', 'name': 'Пунктуація'},
    {'id': 'stylistics', 'name': 'Стилістика'},
    {'id': 'culture_of_speech', 'name': 'Культура мовлення'},
    {'id': 'text_linguistics', 'name': 'Текстознавство'},
  ];

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rulesAsync = ref.watch(dictionaryControllerProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navDictionary),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.spaceS,
              horizontal: AppDimensions.spaceM,
            ),
            child: CustomTextFromField(
              controller: _searchController,
              hintText: AppStrings.searchRules,
              prefixIcon: const Icon(Icons.search),
              onChanged: _onSearchChanged,
              suffixIcon: ref.watch(searchQueryProvider).isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _debounceTimer?.cancel();
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
            ),
          ),
          SizedBox(
            height: AppDimensions.sizeBoxHeight,
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: AppDimensions.spaceM,
                right: AppDimensions.spaceM,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppDimensions.spaceXS),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = selectedCategory == cat['id'];

                return FilterChip(
                  label: Text(cat['name']!),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    ref.read(selectedCategoryProvider.notifier).state =
                        cat['id']!;
                  },
                );
              },
            ),
          ),

          Expanded(
            child: rulesAsync.when(
              data: (rules) {
                if (rules.isEmpty) {
                  return const Center(child: Text(AppStrings.notHaveRule));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.spaceM),
                  itemCount: rules.length,
                  itemBuilder: (context, index) {
                    final rule = rules[index];
                    return RuleCard(rule: rule);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text(
                  AppStrings.errorDownloadDictionary + err.toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
