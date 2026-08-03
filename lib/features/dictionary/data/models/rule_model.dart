import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';

class RuleModel extends RuleEntity {
  RuleModel({
    required super.id,
    required super.title,
    required super.categoryId,
    required super.categoryName,
    required super.summary,
    required super.contentMarkdown,
    required super.examples,
    super.exceptions,
  });

  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      contentMarkdown: json['contentMarkdown'] as String? ?? '',
        examples: (json['examples'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
            const [],

        exceptions: (json['exceptions'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'summary': summary,
      'contentMarkdown': contentMarkdown,
      'example': examples,
      'exceptions': exceptions,
    };
  }
}
