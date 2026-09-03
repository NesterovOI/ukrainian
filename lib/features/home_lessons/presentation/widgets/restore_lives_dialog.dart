import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/export_provider.dart';

class RestoreLivesDialog extends StatelessWidget {
  final VoidCallback onWatchAd;
  final VoidCallback? onCancel;

  const RestoreLivesDialog({super.key, required this.onWatchAd, this.onCancel});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onWatchAd,
    VoidCallback? onCancel,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => RestoreLivesDialog(
        onWatchAd: () {
          dialogContext.pop();
          onWatchAd();
        },
        onCancel: () {
          dialogContext.pop();
          onCancel?.call();
        },
      ),
    );
  }

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
            AppAssets.animationCatChattingLottieAnimation,
            width: AppDimensions.sizeLottie,
            height: AppDimensions.sizeLottie,
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            AppStrings.outOfLivesTitle,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceXS),
          Text(
            AppStrings.outOfLivesSub,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorShadow,
              foregroundColor: AppColors.lightBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
            ),
            onPressed: () {
              onWatchAd();
            },
            label: Text(AppStrings.watchAdButton),
            icon: const Icon(Icons.ondemand_video_rounded),
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                ),
                onPressed: () async {
                  final success = await ref
                      .read(userProgressNotifierProvider.notifier)
                      .buySubscription();
                  if (success && context.mounted) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.premiumOK),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(AppStrings.premiumButton),
              ),
            );
          },
        ),
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              context.pop();
            }
          },
          child: Text(AppStrings.cancelButton),
        ),
      ],
    );
  }
}
