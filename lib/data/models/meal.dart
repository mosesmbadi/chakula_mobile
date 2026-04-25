class Meal {
  final String id;
  final String name;
  final String description;
  final int priceMinKes;
  final int priceMaxKes;
  final List<String> tags;
  final String protein;
  final String carbs;
  final String vegetables;
  final List<String> commonAt;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMinKes,
    required this.priceMaxKes,
    required this.tags,
    required this.protein,
    required this.carbs,
    required this.vegetables,
    required this.commonAt,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      priceMinKes: (json['price_min_kes'] as num?)?.toInt() ?? 0,
      priceMaxKes: (json['price_max_kes'] as num?)?.toInt() ?? 0,
      tags: List<String>.from(json['tags'] as List? ?? []),
      protein: json['protein'] as String? ?? 'low',
      carbs: json['carbs'] as String? ?? 'low',
      vegetables: json['vegetables'] as String? ?? 'low',
      commonAt: List<String>.from(json['common_at'] as List? ?? []),
    );
  }

  Map<String, dynamic> toAcceptPayload({
    int? userCost,
    String? recipeTitle,
    String? recipeInstructions,
  }) => {
    'food_id': id,
    'food_name': name,
    'cost': priceMinKes,
    if (userCost != null) 'user_cost': userCost,
    'currency': 'KES',
    if (recipeInstructions != null && recipeInstructions.isNotEmpty)
      'recipe': {
        if (recipeTitle != null && recipeTitle.isNotEmpty) 'title': recipeTitle,
        'instructions': recipeInstructions,
      },
  };
}
