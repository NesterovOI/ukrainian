import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ukrainian/features/dictionary/data/models/rule_model.dart';

abstract class DictionaryLocalDataSources {
  Future<List<RuleModel>> getAllRules();
}

class DictionaryLocalDataSourceImpl implements DictionaryLocalDataSources {
  final String jsonPath;

  DictionaryLocalDataSourceImpl({this.jsonPath = 'assets/data/rules.json'});

  @override
  Future<List<RuleModel>> getAllRules() async {
    final String response = await rootBundle.loadString(jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => RuleModel.fromJson(json)).toList();
  }
}
