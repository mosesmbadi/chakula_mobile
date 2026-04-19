import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/meal_history_item.dart';
import '../data/repositories/meal_history_repository.dart';
import '../providers/auth_provider.dart';
import '../providers/meal_history_filter_provider.dart';

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
    AsyncNotifierProvider.autoDispose<MealHistoryNotifier, MealHistoryState>(
  MealHistoryNotifier.new,
);

class MealHistoryNotifier extends AutoDisposeAsyncNotifier<MealHistoryState> {
  static const _limit = 20;

  @override
  Future<MealHistoryState> build() async {
    // Watching the filter provider means this rebuilds automatically
    // whenever the user changes region or sub_region — no manual refresh needed.
    final filter = ref.watch(mealHistoryFilterProvider);
    return _fetch(page: 1, region: filter.region, subRegion: filter.subRegion);
  }

  bool get _isAuthenticated => ref.read(authProvider) is AuthAuthenticated;

  Future<MealHistoryState> _fetch({
    required int page,
    String? region,
    String? subRegion,
  }) async {
    final meals = await ref.read(mealHistoryRepositoryProvider).fetchMealHistory(
          region: region,
          subRegion: subRegion,
          page: page,
          limit: _limit,
          authenticated: _isAuthenticated,
        );
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
      final region = filter.region;
      final subRegion = filter.subRegion;

      final nextPage = current.page + 1;
      final more = await ref.read(mealHistoryRepositoryProvider).fetchMealHistory(
            region: region,
            subRegion: subRegion,
            page: nextPage,
            limit: _limit,
            authenticated: _isAuthenticated,
          );

      state = AsyncData(current.copyWith(
        meals: [...current.meals, ...more],
        page: nextPage,
        hasMore: more.length >= _limit,
        isLoadingMore: false,
      ));
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> downvote(String mealId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    // Optimistic remove.
    state = AsyncData(current.copyWith(
      meals: current.meals.where((m) => m.id != mealId).toList(),
    ));

    try {
      await ref.read(mealHistoryRepositoryProvider).downvote(mealId);
    } catch (_) {
      // Restore on failure.
      state = AsyncData(current);
    }
  }
}
