import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/meal.dart';
import '../data/repositories/meal_history_repository.dart';
import '../providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

class MealHistoryState {
  final List<Meal> meals;
  final int page;
  final bool hasMore;

  const MealHistoryState({
    this.meals = const [],
    this.page = 1,
    this.hasMore = true,
  });

  MealHistoryState copyWith({List<Meal>? meals, int? page, bool? hasMore}) {
    return MealHistoryState(
      meals: meals ?? this.meals,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

final mealHistoryProvider =
    AsyncNotifierProvider<MealHistoryNotifier, MealHistoryState>(
  MealHistoryNotifier.new,
);

class MealHistoryNotifier extends AsyncNotifier<MealHistoryState> {
  static const _limit = 20;

  @override
  Future<MealHistoryState> build() async {
    return _load(page: 1);
  }

  String? get _region {
    final onboarding = ref.read(onboardingProvider).value;
    return onboarding?.county; // county name is the sub_region; country is region
  }

  String? get _country {
    final onboarding = ref.read(onboardingProvider).value;
    return onboarding?.country;
  }

  bool get _isAuthenticated => ref.read(authProvider) is AuthAuthenticated;

  Future<MealHistoryState> _load({required int page}) async {
    final repo = ref.read(mealHistoryRepositoryProvider);
    final meals = await repo.fetchMealHistory(
      region: _country,
      subRegion: _region,
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

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(page: 1));
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore) return;

    final repo = ref.read(mealHistoryRepositoryProvider);
    final nextPage = current.page + 1;
    final more = await repo.fetchMealHistory(
      region: _country,
      subRegion: _region,
      page: nextPage,
      limit: _limit,
      authenticated: _isAuthenticated,
    );

    state = AsyncData(current.copyWith(
      meals: [...current.meals, ...more],
      page: nextPage,
      hasMore: more.length >= _limit,
    ));
  }

  Future<void> downvote(String mealId) async {
    await ref.read(mealHistoryRepositoryProvider).downvote(mealId);
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(meals: current.meals.where((m) => m.id != mealId).toList()),
    );
  }
}
