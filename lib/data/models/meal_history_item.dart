class MealHistoryItem {
  final String id;
  final String? userName;
  final String mealName;
  final double cost;
  final String currency;
  final int upvotes;
  final int downvotes;
  final String? region;
  final String? subRegion;
  final String? notes;
  final DateTime eatenAt;

  const MealHistoryItem({
    required this.id,
    required this.mealName,
    required this.cost,
    required this.currency,
    required this.upvotes,
    required this.downvotes,
    required this.eatenAt,
    this.userName,
    this.region,
    this.subRegion,
    this.notes,
  });

  MealHistoryItem copyWith({int? upvotes}) {
    return MealHistoryItem(
      id: id,
      userName: userName,
      mealName: mealName,
      cost: cost,
      currency: currency,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes,
      eatenAt: eatenAt,
      region: region,
      subRegion: subRegion,
      notes: notes,
    );
  }

  factory MealHistoryItem.fromJson(Map<String, dynamic> json) {
    return MealHistoryItem(
      id: json['id'] as String? ?? '',
      userName: json['user_name'] as String?,
      mealName: json['meal_name'] as String? ?? '',
      cost: double.tryParse(json['cost']?.toString() ?? '0') ?? 0,
      currency: json['currency'] as String? ?? 'KES',
      upvotes: json['upvotes'] as int? ?? 0,
      downvotes: json['downvotes'] as int? ?? 0,
      region: json['region'] as String?,
      subRegion: json['subregion'] as String?,
      notes: json['notes'] as String?,
      eatenAt:
          DateTime.tryParse(json['eaten_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
