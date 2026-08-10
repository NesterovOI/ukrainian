import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class QuoteCardWidget extends StatelessWidget {
  final QuoteEntity quote;
  final VoidCallback onRefresh;

  const QuoteCardWidget({
    super.key,
    required this.quote,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onRefresh,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.quoteDay,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.refresh, size: AppDimensions.iconSizeS),
                  const SizedBox(height: AppDimensions.spaceS),
                  Text(
                    '${quote.text}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceXS),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '-${quote.author}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
