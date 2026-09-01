import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/services/purchase_service.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/export_provider.dart';

class ProfileController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> buyPremium() async {
    state = AsyncValue.loading();
    try {
      final purchaseService = ref.read(purchaseServiceProvider);
      final isSuccess = await purchaseService.buySubscription();

      if (isSuccess) {
        ref
            .read(userProgressNotifierProvider.notifier)
            .updatePremiumStatus(true);
      }
      state = const AsyncValue.data(null);
      return isSuccess;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<void> restorePurchase() async {
    state = AsyncValue.loading();
    try {
      final purchaseService = ref.read(purchaseServiceProvider);
      await purchaseService.restorePurchases();
      final hasActiveSubscription = await purchaseService
          .checkSubscriptionStatus();

      await ref
          .read(userProgressNotifierProvider.notifier)
          .updatePremiumStatus(hasActiveSubscription);

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, void>(ProfileController.new);
