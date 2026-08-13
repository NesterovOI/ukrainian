import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ukrainian/core/theme/theme.dart';

class OutOfLivesDialog extends StatelessWidget {
  final VoidCallback onWatchAd;
  final VoidCallback onCancel;

  const OutOfLivesDialog({
    super.key,
    required this.onWatchAd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      contentPadding: const EdgeInsets.all(AppDimensions.spaceM),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            AppAssets.animationCatThinkingAnimation,
            width: AppDimensions.sizeLottie,
            height: AppDimensions.sizeLottie,
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
              AppStrings.outOfLivesTitle,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceXS,),
          Text(
            AppStrings.outOfLivesSub,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL,),
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton.icon(
                onPressed: onWatchAd,
                icon: const Icon(Icons.play_circle_fill_rounded),
                label: Text(AppStrings.watchAdButton),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceS,),
          TextButton(
              onPressed: onCancel,
              child: Text(AppStrings.cancelButton)
          ),
        ],
      ),
    );
  }
}
