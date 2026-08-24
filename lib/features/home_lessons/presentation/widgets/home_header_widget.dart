import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class HomeHeaderWidget extends StatelessWidget {
  final UserProgressEntity progress;
  final VoidCallback? onLivesTap;

  const HomeHeaderWidget({super.key, required this.progress, this.onLivesTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: Theme.of(
            context,
          ).dividerColor.withValues(alpha: AppDimensions.opacityXXXXS),
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
            label: AppStrings.dayLabelHomeLessons,
          ),

          // 2. Бали (Score)
          _StatItemSvg(
            assetName: AppAssets.iconTrophy,
            value: '${progress.score}',
            label: AppStrings.pointsLabelHomeLessons,
          ),

          // 3. Життя (Lives)
          _LivesStatItem(
            lives: progress.lives,
            maxLives: progress.maxLives,
            label: AppStrings.livesLabelHomeLessons,
            onTab: onLivesTap,
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
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
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
        const SizedBox(width: AppDimensions.spaceXS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class _LivesStatItem extends StatefulWidget {
  final int lives;
  final int maxLives;
  final String label;
  final VoidCallback? onTab;

  _LivesStatItem({
    required this.lives,
    required this.maxLives,
    required this.label,
    this.onTab,
  });
  @override
  State<_LivesStatItem> createState() => _LivesStatItemState();
}

class _LivesStatItemState extends State<_LivesStatItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppDimensions.animXXXXS),
    );

    _scaleAnimation = Tween<double>(
      begin: AppDimensions.opacityXXXL,
      end: AppDimensions.opasityXM,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.lives <= 1) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant _LivesStatItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lives <= 1) {
      if (!_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTab,
      borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceXS,
          vertical: AppDimensions.spaceXXS,
        ),
        child: Row(
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: SvgPicture.asset(
                AppAssets.iconHeart,
                width: AppDimensions.iconSizeM,
                height: AppDimensions.iconSizeM,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceXS),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.lives}/${widget.maxLives}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: widget.lives <= 1 ? AppColors.error : null,
                  ),
                ),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
