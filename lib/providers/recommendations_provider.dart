import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/meal.dart';
import '../data/repositories/recommendations_repository.dart';
import '../providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

final recommendationsProvider =
    AsyncNotifierProvider<RecommendationsNotifier, Map<String, List<Meal>>>(
  RecommendationsNotifier.new,
);

class RecommendationsNotifier extends AsyncNotifier<Map<String, List<Meal>>> {
  @override
  Future<Map<String, List<Meal>>> build() async {
    final repo = ref.read(recommendationsRepositoryProvider);
    final isAuthenticated = ref.read(authProvider) is AuthAuthenticated;
    return repo.fetchAll(
      budget: _resolveBudget(),
      region: _resolveRegion(),
      authenticated: isAuthenticated,
    );
  }

  int _resolveBudget() {
    final authState = ref.read(authProvider);
    if (authState is AuthAuthenticated) return authState.user.dailyBudget;
    return ref.read(onboardingProvider).value?.budget ?? 200;
  }

  String _resolveRegion() {
    return ref.read(onboardingProvider).value?.country ?? 'kenya';
  }

  Future<String?> acceptMeal(String mealType, List<Meal> foods) async {
    try {
      await ref.read(recommendationsRepositoryProvider).acceptMeal(
            mealType: mealType,
            foods: foods,
          );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> acceptDayPlan(Map<String, List<Meal>> plan) async {
    try {
      await ref.read(recommendationsRepositoryProvider).acceptDayPlan(plan);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(recommendationsRepositoryProvider);
      final isAuthenticated = ref.read(authProvider) is AuthAuthenticated;
      return repo.fetchAll(budget: _resolveBudget(), region: _resolveRegion(), authenticated: isAuthenticated);
    });
  }
}
