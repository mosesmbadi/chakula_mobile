import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api_client.dart';
import '../models/recipe.dart';

final recipesRepositoryProvider = Provider<RecipesRepository>((ref) {
  return RecipesRepository(ref.read(apiClientProvider));
});

class RecipesRepository {
  final ApiClient _client;

  RecipesRepository(this._client);

  Future<List<Recipe>> fetchRecipes({
    String? userId,
    String? foodId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final data = await _client.get(
        '/recipes',
        queryParams: {
          'page': '$page',
          'limit': '$limit',
          if (userId != null) 'user_id': userId,
          if (foodId != null) 'food_id': foodId,
        },
      );
      final rawList = data['data'] as List?;
      if (rawList == null) return [];
      return rawList
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      if (e.statusCode == 404) return [];
      rethrow;
    }
  }

  Future<Recipe?> fetchRecipe(String id) async {
    try {
      final data = await _client.get('/recipes/$id');
      return Recipe.fromJson(data);
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }
}
