import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';

class QuoteModel extends QuoteEntity {
  const QuoteModel({
    required super.id,
    required super.text,
    required super.author,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      author: json['author'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
    };
  }
}
