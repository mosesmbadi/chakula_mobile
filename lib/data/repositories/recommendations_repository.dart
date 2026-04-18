import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api_client.dart';
import '../models/meal.dart';

final recommendationsRepositoryProvider = Provider<RecommendationsRepository>((ref) {
  return RecommendationsRepository(ref.read(apiClientProvider));
});

class RecommendationsRepository {
  static const _mealTypes = ['breakfast', 'lunch', 'dinner'];

  final ApiClient _client;

  RecommendationsRepository(this._client);

  Future<Map<String, List<Meal>>> fetchAll({
    required int budget,
    required String region,
    bool authenticated = false,
  }) async {
    final results = await Future.wait(
      _mealTypes.map((type) => _fetchMealType(
            type,
            budget: budget,
            region: region,
            authenticated: authenticated,
          )),
    );

    return {
      for (int i = 0; i < _mealTypes.length; i++)
        if (results[i] != null) _mealTypes[i]: results[i]!,
    };
  }

  Future<List<Meal>?> _fetchMealType(
    String mealType, {
    required int budget,
    required String region,
    required bool authenticated,
  }) async {
    try {
      final Map<String, dynamic> data;

      if (authenticated) {
        data = await _client.get(
          '/recommendations/foods/recommend',
          queryParams: {'mealType': mealType},
          authenticated: true,
        );
      } else {
        data = await _client.get(
          '/public/recommendations/foods/recommend',
          queryParams: {
            'mealType': mealType,
            'budget': budget.toString(),
            'region': region,
          },
          authenticated: false,
        );
      }

      final recs = data['recommendations'] as Map<String, dynamic>?;
      final foods = recs?['foods'] as List?;
      return foods?.map((f) => Meal.fromJson(f as Map<String, dynamic>)).toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> acceptMeal({
    required String mealType,
    required List<Meal> foods,
    int? userCost,
    String? imagePath,
  }) async {
    await _client.postMultipart(
      '/recommendations/accept',
      fields: {
        'mealType': mealType,
        'foods': jsonEncode(foods.map((f) => f.toAcceptPayload(userCost: userCost)).toList()),
      },
      imagePath: imagePath,
    );
  }

  Future<void> acceptDayPlan(Map<String, List<Meal>> plan) async {
    await _client.post(
      '/recommendations/accept/plan',
      body: {
        'plan': {
          for (final entry in plan.entries)
            entry.key: entry.value.take(1).map((f) => f.toAcceptPayload()).toList(),
        },
      },
    );
  }
}
