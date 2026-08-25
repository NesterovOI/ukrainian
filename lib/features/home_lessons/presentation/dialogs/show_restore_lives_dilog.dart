import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/theme/theme.dart';

void showRestoreLivesDialog({
  required BuildContext context,
  required VoidCallback onWatchAd,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXM),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              AppAssets.iconHeart,
              width: AppDimensions.iconSizeM,
              height: AppDimensions.iconSizeM,
            ),
            SizedBox(width: AppDimensions.spaceXS),
            Text(AppStrings.outOfLivesTitle),
          ],
        ),
        content: Text(AppStrings.outOfLivesSub),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(AppStrings.cancelButton),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorShadow,
              foregroundColor: AppColors.lightBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
            ),
            onPressed: () {
              context.pop();
              onWatchAd;
            },
            label: Text(AppStrings.watchAdButton),
            icon: const Icon(Icons.ondemand_video_rounded),
          ),
        ],
      );
    },
  );
}
