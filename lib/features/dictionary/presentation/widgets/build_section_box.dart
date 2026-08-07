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
          ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
            child: Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: AppDimensions.spaceXS,
                    runSpacing: AppDimensions.spaceXS,
                    children: items.map((item){
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.spaceS,
                          vertical: AppDimensions.spaceXXS,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                          border: Border.all(
                            color: borderColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: true,
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
