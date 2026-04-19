import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api_client.dart';
import '../models/meal_history_item.dart';

final mealHistoryRepositoryProvider = Provider<MealHistoryRepository>((ref) {
  return MealHistoryRepository(ref.read(apiClientProvider));
});

class MealHistoryRepository {
  final ApiClient _client;

  MealHistoryRepository(this._client);

  Future<List<MealHistoryItem>> fetchMealHistory({
    String? region,
    String? subRegion,
    int page = 1,
    int limit = 20,
    bool authenticated = false,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      if (region != null && region.isNotEmpty) 'region': region,
      if (subRegion != null && subRegion.isNotEmpty) 'sub_region': subRegion,
    };

    final data = await _client.get(
      '/meal-history',
      queryParams: queryParams,
      authenticated: authenticated,
    );

    final rawList = data['data'] as List?;
    if (rawList == null) return [];
    return rawList
        .map((item) => MealHistoryItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> logMeal({
    required String mealName,
    required double cost,
    String currency = 'KES',
    double? userCost,
    String? notes,
    String? recipeTitle,
    String? recipeInstructions,
  }) async {
    await _client.post(
      '/users/meal-history',
      body: {
        'mealName': mealName,
        'cost': cost,
        'currency': currency,
        'userCost': userCost ?? cost,
        'rating': null,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
        if (recipeInstructions != null && recipeInstructions.isNotEmpty)
          'recipe': {
            if (recipeTitle != null && recipeTitle.isNotEmpty) 'title': recipeTitle,
            'instructions': recipeInstructions,
          },
      },
    );
  }

  Future<void> upvote(String mealId) async {
    await _client.put('/meal-history/$mealId/upvote');
  }

  Future<void> downvote(String mealId) async {
    await _client.post('/meal-history/$mealId/downvote', body: {});
  }
}
