import 'package:isar_community/isar.dart';

part 'meal_history_item.g.dart';

@collection
class MealHistoryItem {
  Id get isarId => fastHash(id);

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
  final String? foodId;
  final String? recipeTitle;
  final String? recipeInstructions;
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
    this.foodId,
    this.recipeTitle,
    this.recipeInstructions,
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
      foodId: foodId,
      recipeTitle: recipeTitle,
      recipeInstructions: recipeInstructions,
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
      foodId: json['meal_id'] as String?,
      recipeTitle: json['recipe_title'] as String?,
      recipeInstructions: json['recipe_instructions'] as String?,
      eatenAt:
          DateTime.tryParse(json['eaten_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;
  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }
  return hash;
}
