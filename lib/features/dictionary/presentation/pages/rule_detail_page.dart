import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';
import 'package:ukrainian/features/dictionary/presentation/widgets/widgets.dart';

class RuleDetailPage extends StatelessWidget {
  final RuleEntity rule;
  const RuleDetailPage({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rule.categoryName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:  const EdgeInsets.all(AppDimensions.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                      rule.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: AppDimensions.spaceXL,),
                  MarkdownBody(
                      data: rule.contentMarkdown,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                      p: Theme.of(context).textTheme.bodyLarge,
                      h3: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceL,),
                // Блок Прикладів
                if (rule.examples.isNotEmpty) ...[
                  BuildSectionBox(
                      context: context,
                      title: AppStrings.ruleExamplesDictionary,
                      color: AppColors.success,
                      borderColor: AppColors.successShadow,
                      items: rule.examples
                  ),
                ],
                // Блок Винятків
                if (rule.exceptions != null && rule.exceptions!.isNotEmpty) ...[
                  BuildSectionBox(
                      context: context,
                      title: AppStrings.ruleExceptionsDictionary,
                      color: AppColors.primary,
                      borderColor: AppColors.primaryShadow,
                      items: rule.exceptions!,
                  ),
                ],
              ],
          ),
        ),
    );
  }
}
