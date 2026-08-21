import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static RewardedAd? _rewardedAd;
  static final String _rewardedAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712484694';

  static Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  static Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
        },
      ),
    );
  }

  static Future<bool> showRewardedAd(BuildContext context) async {
    if (_rewardedAd == null) {
      await loadRewardedAd();
      return true; // Ad is not ready yet
    }

    bool isRewarded = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        ad.dispose();
        loadRewardedAd(); // Load a new ad for the next time
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadRewardedAd(); // Load a new ad for the next time
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        isRewarded = true;
      },
    );

    _rewardedAd = null; // Reset the rewarded ad after showing
    return isRewarded;
  }
}
