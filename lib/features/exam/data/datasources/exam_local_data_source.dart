import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ukrainian/features/exam/data/models/exam_model.dart';
import 'package:ukrainian/core/theme/theme.dart';

abstract class ExamLocalDataSource {
  Future<ExamModel> loadExamJson(String examId);
  Future<List<ExamModel>> loadAllExamsJson();
}

class ExamLocalDataSourceImpl extends ExamLocalDataSource {
  final AssetBundle _assetBundle;

  ExamLocalDataSourceImpl({AssetBundle? assetBundle})
    : _assetBundle = assetBundle ?? rootBundle;

  @override
  Future<ExamModel> loadExamJson(String examId) async {
    try {
      final String jsonString = await _assetBundle.loadString(
        'assets/exams/$examId.json',
      );
      final Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;
      return ExamModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception(
        AppStrings.notLoadExam + examId + AppStrings.errorExam + e.toString(),
      );
    }
  }

  @override
  Future<List<ExamModel>> loadAllExamsJson() async {
    List<ExamModel> exams = [];
    for (int i = 1; i <= 50; i++) {
      try {
        final exam = await loadExamJson('nmt_ukrainian_test$i');
        exams.add(exam);
      } catch (_) {
        break;
      }
    }
    if (exams.isEmpty) {
      final demo = await loadExamJson('nmt_2024_demo');
      exams.add(demo);
    }

    return exams;
  }
}
