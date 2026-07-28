import 'package:flutter/material.dart';
import 'package:ukrainian/core/theme/app_dimensions.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'DictionaryPage',
        style: TextStyle(
          fontSize: AppDimensions.fontDisplay,
        ),
      ),
    );
  }
}
