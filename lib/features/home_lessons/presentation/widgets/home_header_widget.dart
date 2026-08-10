import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class HomeHeaderWidget extends StatelessWidget {
  final UserProgressEntity progress;

  const HomeHeaderWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1. Дні поспіль (Streak)
          _StatItem(
              icon: Icons.local_fire_department_rounded,
              iconColor: AppColors.streakDays,
              value: '${progress.streakDays}',
              label: AppStrings.dayLabelHomeLessons
          ),

          // 2. Бали (Score)
          _StatItemSvg(
              assetName: AppAssets.iconTrophy,
              value: '${progress.score}',
              label: AppStrings.pointsLabelHomeLessons,
          ),

          // 3. Життя (Lives)
          _StatItemSvg(
              assetName: AppAssets.iconHeart,
              value: '${progress.lives}',
              label: AppStrings.livesLabelHomeLessons,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: AppDimensions.iconSizeM),
        const SizedBox(width: AppDimensions.spaceXS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleMedium,),
            Text(label, style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ],
    );
  }
}

class _StatItemSvg extends StatelessWidget {
  final String assetName;
  final String value;
  final String label;

  const _StatItemSvg({
    super.key,
    required this.assetName,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
            assetName,
            width: AppDimensions.iconSizeM,
            height: AppDimensions.iconSizeM,
        ),
        const SizedBox(width: AppDimensions.spaceXS,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            Text(label, style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
      ],
    );
  }
}

