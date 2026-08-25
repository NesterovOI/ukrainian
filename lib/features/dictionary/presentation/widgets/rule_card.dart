import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';

class RuleCard extends StatelessWidget {
  final RuleEntity rule;
  const RuleCard({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        onTap: () {
          context.pushNamed(AppRouters.ruleDetailName, extra: rule);
        },
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceS,
                      vertical: AppDimensions.spaceXXS,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusS,
                      ),
                    ),
                    child: Text(
                      rule.categoryName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: AppDimensions.iconSizeS,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceS),
              Text(
                rule.title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
