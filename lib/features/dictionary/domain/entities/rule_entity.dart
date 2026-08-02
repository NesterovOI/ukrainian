class RuleEntity {
  final String id;
  final String title;
  final String categoryId;
  final String categoryName;
  final String summary;
  final String contentMarkDown;
  final List<String> examples;
  final List<String>? exceptions;

  RuleEntity({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.categoryName,
    required this.summary,
    required this.contentMarkDown,
    required this.examples,
    this.exceptions,
});
}