class Meal {
  final String id;
  final String name;
  final int priceMinKes;
  final List<String> commonAt;

  const Meal({
    required this.id,
    required this.name,
    required this.priceMinKes,
    required this.commonAt,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      priceMinKes: (json['price_min_kes'] as num?)?.toInt() ?? 0,
      commonAt: List<String>.from(json['common_at'] as List? ?? []),
    );
  }

  Map<String, dynamic> toAcceptPayload() => {
        'food_id': id,
        'food_name': name,
        'cost': priceMinKes,
      };
}
