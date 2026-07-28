import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/core/theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startInitAndNavigate();
  }

  Future<void> _startInitAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    context.go(AppRouter.createPassword);
  }

  @override
  Widget build(BuildContext context) {
    //Отримую ширину екрана для адаптивності між різними розмірами екрана
    final screenWith = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWith * 0.5,
              height: screenWith * 0.5,
              child: Lottie.asset(
                AppAssets.animationCatThinkingAnimation,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: AppDimensions.spaceL,),
            Text(
                AppStrings.appTitle,
                style: theme.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
