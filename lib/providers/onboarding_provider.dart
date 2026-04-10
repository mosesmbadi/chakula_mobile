import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/isar_service.dart';
import '../data/models/onboarding_data.dart';

final isarServiceProvider = Provider<IsarService>((ref) => IsarService());

class OnboardingDraft {
  final String name;
  final String region;
  final String subRegion;
  final int budget;
  final List<String> dietaryGoals;

  const OnboardingDraft({
    this.name = '',
    this.region = 'kenya',
    this.subRegion = 'nairobi',
    this.budget = 200,
    this.dietaryGoals = const ['high-fibre'],
  });

  OnboardingDraft copyWith({
    String? name,
    String? region,
    String? subRegion,
    int? budget,
    List<String>? dietaryGoals,
  }) {
    return OnboardingDraft(
      name: name ?? this.name,
      region: region ?? this.region,
      subRegion: subRegion ?? this.subRegion,
      budget: budget ?? this.budget,
      dietaryGoals: dietaryGoals ?? this.dietaryGoals,
    );
  }
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingDraft>(OnboardingNotifier.new);

class OnboardingNotifier extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() {
    _loadFromIsar();
    return const OnboardingDraft();
  }

  IsarService get _isar => ref.read(isarServiceProvider);

  Future<void> _loadFromIsar() async {
    final data = await _isar.getOnboardingData();
    if (data != null) {
      state = OnboardingDraft(
        name: data.name,
        region: data.region,
        subRegion: data.subRegion,
        budget: data.dailyBudget,
        dietaryGoals: data.dietaryGoals,
      );
    }
  }

  Future<void> setName(String name) async {
    state = state.copyWith(name: name);
    await _persist();
  }

  Future<void> setLocation({required String region, required String subRegion}) async {
    state = state.copyWith(region: region, subRegion: subRegion);
    await _persist();
  }

  Future<void> setBudget(int budget) async {
    state = state.copyWith(budget: budget);
    await _persist();
  }

  Future<void> setDietaryGoals(List<String> goals) async {
    state = state.copyWith(dietaryGoals: goals);
    await _persist();
  }

  Future<void> clear() async {
    state = const OnboardingDraft();
    await _isar.clearOnboardingData();
  }

  Future<void> _persist() async {
    final data = OnboardingData(
      name: state.name,
      region: state.region,
      subRegion: state.subRegion,
      dailyBudget: state.budget,
      dietaryGoals: state.dietaryGoals,
    );
    await _isar.saveOnboardingData(data);
  }
}
