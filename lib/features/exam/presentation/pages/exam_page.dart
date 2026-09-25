import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/app_dimensions.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ExamPage',
        style: TextStyle(fontSize: AppDimensions.fontDisplay),
      ),
    );
  }
}
