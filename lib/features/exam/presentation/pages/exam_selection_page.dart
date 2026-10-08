import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/navigation/app_router.dart';

class ExamSelectionPage extends StatelessWidget {
  const ExamSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Selection')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the exam page with a specific exam ID
            context.push(AppRouters.examPagePath, extra: 'nmt_2024_demo');
          },
          child: const Text('Start Exam'),
        ),
      ),
    );
  }
}
