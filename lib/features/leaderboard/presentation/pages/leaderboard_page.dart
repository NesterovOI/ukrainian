import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/app_dimensions.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'LeaderboardPage',
        style: TextStyle(
          fontSize: AppDimensions.fontDisplay,
        ),
      ),
    );
  }
}

