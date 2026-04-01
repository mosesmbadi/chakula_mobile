import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingDraft {
  final String name;
  final int budget;
  final List<String> dietaryGoals;

  const OnboardingDraft({
    this.name = '',
    this.budget = 200,
    this.dietaryGoals = const ['high-fibre'],
  });

  OnboardingDraft copyWith({
    String? name,
    int? budget,
    List<String>? dietaryGoals,
  }) {
    return OnboardingDraft(
      name: name ?? this.name,
      budget: budget ?? this.budget,
      dietaryGoals: dietaryGoals ?? this.dietaryGoals,
    );
  }
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingDraft>(OnboardingNotifier.new);

class OnboardingNotifier extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() => const OnboardingDraft();

  void setName(String name) => state = state.copyWith(name: name);
  void setBudget(int budget) => state = state.copyWith(budget: budget);
  void setDietaryGoals(List<String> goals) => state = state.copyWith(dietaryGoals: goals);
}
