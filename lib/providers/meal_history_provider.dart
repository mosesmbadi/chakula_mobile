import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/meal_history_item.dart';
import '../data/repositories/meal_history_repository.dart';
import '../providers/auth_provider.dart';
import '../providers/meal_history_filter_provider.dart';
import '../providers/onboarding_provider.dart';

class MealHistoryState {
  final List<MealHistoryItem> meals;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  const MealHistoryState({
    this.meals = const [],
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  MealHistoryState copyWith({
    List<MealHistoryItem>? meals,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return MealHistoryState(
      meals: meals ?? this.meals,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final mealHistoryProvider =
    AsyncNotifierProvider<MealHistoryNotifier, MealHistoryState>(
      MealHistoryNotifier.new,
    );

class MealHistoryNotifier extends AsyncNotifier<MealHistoryState> {
  static const _limit = 20;

  bool get _isAuthenticated => ref.read(authProvider) is AuthAuthenticated;

  @override
  Future<MealHistoryState> build() async {
    final filter = ref.watch(mealHistoryFilterProvider);
    final isar = ref.read(isarServiceProvider);

    // Show cached data immediately so the screen is not blank while the API loads.
    final cached = await isar.getCachedMealHistory(
      region: filter.region,
      subRegion: filter.subRegion,
      limit: _limit,
    );
    if (cached.isNotEmpty) {
      state = AsyncData(MealHistoryState(
        meals: cached,
        page: 1,
        hasMore: cached.length >= _limit,
      ));
    }

    return _fetch(page: 1, region: filter.region, subRegion: filter.subRegion);
  }

  Future<MealHistoryState> _fetch({
    required int page,
    String? region,
    String? subRegion,
  }) async {
    final meals = await ref
        .read(mealHistoryRepositoryProvider)
        .fetchMealHistory(
          region: region,
          subRegion: subRegion,
          page: page,
          limit: _limit,
          authenticated: _isAuthenticated,
        );

    // Upsert fresh page-1 results; clear stale items first so removed meals
    // don't linger in the cache across sessions.
    if (page == 1 && meals.isNotEmpty) {
      final isar = ref.read(isarServiceProvider);
      await isar.clearMealHistoryCache();
      await isar.cacheMealHistory(meals);
    }

    return MealHistoryState(
      meals: meals,
      page: page,
      hasMore: meals.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    // Show a spinner at the bottom without wiping the existing list.
    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final filter = ref.read(mealHistoryFilterProvider);
      final nextPage = current.page + 1;
      final more = await ref
          .read(mealHistoryRepositoryProvider)
          .fetchMealHistory(
            region: filter.region,
            subRegion: filter.subRegion,
            page: nextPage,
            limit: _limit,
            authenticated: _isAuthenticated,
          );

      // Persist additional pages so returning users see more content instantly.
      if (more.isNotEmpty) {
        await ref.read(isarServiceProvider).cacheMealHistory(more);
      }

      state = AsyncData(
        current.copyWith(
          meals: [...current.meals, ...more],
          page: nextPage,
          hasMore: more.length >= _limit,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> upvote(String mealId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    // Optimistic increment.
    state = AsyncData(
      current.copyWith(
        meals: current.meals
            .map((m) => m.id == mealId ? m.copyWith(upvotes: m.upvotes + 1) : m)
            .toList(),
      ),
    );

    try {
      await ref.read(mealHistoryRepositoryProvider).upvote(mealId);
    } catch (_) {
      // Restore on failure.
      state = AsyncData(current);
    }
  }

  Future<void> downvote(String mealId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    // Optimistic remove.
    state = AsyncData(
      current.copyWith(
        meals: current.meals.where((m) => m.id != mealId).toList(),
      ),
    );

    try {
      await ref.read(mealHistoryRepositoryProvider).downvote(mealId);
    } catch (_) {
      // Restore on failure.
      state = AsyncData(current);
    }
  }

  Future<void> logMeal({
    required String mealName,
    required double cost,
    String currency = 'KES',
    double? userCost,
    String? notes,
    String? recipeTitle,
    String? recipeInstructions,
    String? imagePath,
  }) async {
    await ref
        .read(mealHistoryRepositoryProvider)
        .logMeal(
          mealName: mealName,
          cost: cost,
          currency: currency,
          userCost: userCost,
          notes: notes,
          recipeTitle: recipeTitle,
          recipeInstructions: recipeInstructions,
          imagePath: imagePath,
        );
    // Clear stale cache so the new entry appears on next load.
    await ref.read(isarServiceProvider).clearMealHistoryCache();
    ref.invalidateSelf();
  }
}
