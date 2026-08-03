import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/theme.dart';

class BuildSectionBox extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Color color;
  final Color borderColor;
  final List<String> items;

  const BuildSectionBox({
    super.key,
    required this.context,
    required this.title,
    required this.color,
    required this.borderColor,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: borderColor, width: AppDimensions.spaceXXXXS),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppDimensions.spaceS,),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Chip(
                  label: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
