import 'package:flutter/material.dart';

class AdService {
  static Future<bool> showRewardedAd(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.pop(context);
    }
    return true;
  }
}