class Recipe {
  final String id;
  final String title;
  final String instructions;
  final String createdBy;
  final DateTime createdAt;

  const Recipe({
    required this.id,
    required this.title,
    required this.instructions,
    required this.createdBy,
    required this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      instructions: json['instructions'] as String? ?? '',
      createdBy: json['created_by'] as String? ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
