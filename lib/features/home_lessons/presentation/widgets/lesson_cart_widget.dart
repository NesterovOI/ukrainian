import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class LessonCartWidget extends StatelessWidget {
  final LessonEntity lesson;
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback onTap;

  const LessonCartWidget({
    super.key,
    required this.lesson,
    required this.isLocked,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = isLocked
        ? AppDimensions.opacityXXS
        : AppDimensions.opacityXXXL;
    return Opacity(
      opacity: opacity,
      child: Card(
        margin: EdgeInsets.only(bottom: AppDimensions.spaceM),
        elevation: 2,
        child: InkWell(
          onTap: isLocked ? null : onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.spaceXXXL,
                  height: AppDimensions.spaceXXXL,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.success.withValues(
                            alpha: AppDimensions.opacityXXXS,
                          )
                        : Theme.of(context).colorScheme.primary.withValues(
                            alpha: AppDimensions.opacityXXXXS,
                          ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isLocked
                        ? SvgPicture.asset(
                            AppAssets.iconLock,
                            width: AppDimensions.iconSizeS,
                            height: AppDimensions.iconSizeS,
                          )
                        : isCompleted
                        ? const Icon(Icons.check, color: AppColors.success)
                        : Text(
                            '${lesson.order}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppDimensions.spaceXXXXS),
                      Text(
                        lesson.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: AppDimensions.iconSizeS,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
