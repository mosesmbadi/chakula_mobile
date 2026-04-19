import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/recipe.dart';
import '../data/repositories/recipes_repository.dart';
import '../providers/auth_provider.dart';

// Used by home screen — fetches a small preview, auth-gated.
final homeRecipesProvider = FutureProvider.autoDispose<List<Recipe>>((ref) async {
  if (ref.watch(authProvider) is! AuthAuthenticated) return [];
  return ref.read(recipesRepositoryProvider).fetchRecipes(limit: 5);
});

// Used by the full recipes screen — paginated.
class RecipesState {
  final List<Recipe> recipes;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  const RecipesState({
    this.recipes = const [],
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  RecipesState copyWith({
    List<Recipe>? recipes,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return RecipesState(
      recipes: recipes ?? this.recipes,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final recipesProvider =
    AsyncNotifierProvider.autoDispose<RecipesNotifier, RecipesState>(
  RecipesNotifier.new,
);

class RecipesNotifier extends AutoDisposeAsyncNotifier<RecipesState> {
  static const _limit = 20;

  @override
  Future<RecipesState> build() async {
    final recipes = await ref
        .read(recipesRepositoryProvider)
        .fetchRecipes(page: 1, limit: _limit);
    return RecipesState(
      recipes: recipes,
      page: 1,
      hasMore: recipes.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final nextPage = current.page + 1;
      final more = await ref
          .read(recipesRepositoryProvider)
          .fetchRecipes(page: nextPage, limit: _limit);

      state = AsyncData(current.copyWith(
        recipes: [...current.recipes, ...more],
        page: nextPage,
        hasMore: more.length >= _limit,
        isLoadingMore: false,
      ));
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }
}
