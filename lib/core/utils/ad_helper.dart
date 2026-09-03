import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/services/service.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/export_provider.dart';

Future<bool> showRewardedAdAndRestoreLive(
  BuildContext context,
  WidgetRef ref,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(AppStrings.watchAdButton),
      duration: Duration(seconds: 1),
    ),
  );

  final isPremium =
      ref.read(userProgressNotifierProvider).value?.isPremium ?? false;

  if (isPremium) return true;

  final bool isRewarded = await AdService.showRewardedAd(context);

  if (isRewarded) {
    await ref.read(userProgressNotifierProvider.notifier).restoreLifeFromAd();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.welcomeLife),
          backgroundColor: AppColors.success,
        ),
      );
    }
    return true;
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.notAdvertising)));
    }
    return false;
  }
}
