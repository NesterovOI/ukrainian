import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/dictionary/presentation/providers/dictionary_controller.dart';
import 'package:ukrainian/features/dictionary/presentation/widgets/rule_card.dart';

class DictionaryPage extends ConsumerWidget {
  const DictionaryPage({super.key});

  static const categories = [
    {'id': 'all', 'name': 'Всі правила'},
    {'id': 'phonetics', 'name': 'Фонетика'},
    {'id': 'grafika', 'name': 'Графіка'},
    {'id': 'orfoepia', 'name': 'Орфоепія'},
    {'id': 'orthography', 'name': 'Орфографія'},
    {'id': 'leksukologia', 'name': 'Лексикологія'},
    {'id': 'frazeologia', 'name': 'Фразеологія'},
    {'id': 'build_word', 'name': 'Будова слова і словотвір'},
    {'id': 'morphology', 'name': 'Морфологія'},
    {'id': 'suntaksus', 'name': 'Синтаксис'},
    {'id': 'pynktyacia', 'name': 'Пунктуація'},
    {'id': 'stulistuka', 'name': 'Стилістика'},
    {'id': 'kyltyra_movlena', 'name': 'Культура мовлення'},
    {'id': 'tekstoznavstvo', 'name': 'Текстознавство'},
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(dictionaryControllerProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navDictionary),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppDimensions.sizeBoxHeight,
            child: ListView.separated(
                padding: EdgeInsets.only(left: AppDimensions.spaceM, right: AppDimensions.spaceM),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_,__) => const SizedBox(width: AppDimensions.spaceXS,),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat['id'];

                  return FilterChip(
                      label: Text(cat['name']!),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        ref.read(selectedCategoryProvider.notifier).state = cat['id']!;
                      }
                  );
                },
            ),
          ),

          Expanded(
              child: rulesAsync.when(
                  data: (rules) {
                    if (rules.isEmpty) {
                      return const Center(
                        child: Text(AppStrings.notHaveRule),
                      );
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
                  loading: () => const Center(child: CircularProgressIndicator(),),
                  error: (err, stack) => Center(
                    child: Text(AppStrings.errorDownloadDictionary + err.toString()),
                  ),
              ),
          ),
        ],
      ),
    );
  }
  
}

