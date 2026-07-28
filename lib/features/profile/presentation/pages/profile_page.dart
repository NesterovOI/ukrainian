import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/app_dimensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ProfilePage',
        style: TextStyle(fontSize: AppDimensions.fontDisplay),
      ),
    );
  }
}
