import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/isar_service.dart';
import '../data/models/onboarding_data.dart';

final isarServiceProvider = Provider<IsarService>((ref) => IsarService());

class OnboardingDraft {
  final String name;
  final String country;
  final String county;
  final String region;
  final String subRegion;
  final int budget;
  final List<String> dietaryGoals;

  const OnboardingDraft({
    this.name = '',
    this.country = 'kenya',
    this.county = 'Nairobi',
    this.region = 'kenya',
    this.subRegion = 'nairobi',
    this.budget = 200,
    this.dietaryGoals = const ['high-fibre'],
  });

  OnboardingDraft copyWith({
    String? name,
    String? country,
    String? county,
    String? region,
    String? subRegion,
    int? budget,
    List<String>? dietaryGoals,
  }) {
    return OnboardingDraft(
      name: name ?? this.name,
      country: country ?? this.country,
      county: county ?? this.county,
      region: region ?? this.region,
      subRegion: subRegion ?? this.subRegion,
      budget: budget ?? this.budget,
      dietaryGoals: dietaryGoals ?? this.dietaryGoals,
    );
  }
}

final onboardingProvider =
    AsyncNotifierProvider<OnboardingNotifier, OnboardingDraft>(OnboardingNotifier.new);

class OnboardingNotifier extends AsyncNotifier<OnboardingDraft> {
  @override
  Future<OnboardingDraft> build() async {
    final isar = ref.read(isarServiceProvider);
    final data = await isar.getOnboardingData();
    
    if (data != null) {
      return OnboardingDraft(
        name: data.name,
        country: data.region,
        county: data.county,
        region: data.region,
        subRegion: data.subRegion,
        budget: data.dailyBudget,
        dietaryGoals: data.dietaryGoals,
      );
    }
    
    return const OnboardingDraft();
  }

  IsarService get _isar => ref.read(isarServiceProvider);

  Future<void> setName(String name) async {
    final current = await future;
    state = AsyncValue.data(current.copyWith(name: name));
    await _persist(state.value!);
  }

  Future<void> setCountry(String country) async {
    final current = await future;
    state = AsyncValue.data(current.copyWith(country: country, region: country));
    await _persist(state.value!);
  }

  Future<void> setLocation({
    required String county,
    required String region,
    required String subRegion,
  }) async {
    final current = await future;
    state = AsyncValue.data(current.copyWith(county: county, region: region, subRegion: subRegion));
    await _persist(state.value!);
  }

  Future<void> setBudget(int budget) async {
    final current = await future;
    state = AsyncValue.data(current.copyWith(budget: budget));
    await _persist(state.value!);
  }

  Future<void> setDietaryGoals(List<String> goals) async {
    final current = await future;
    state = AsyncValue.data(current.copyWith(dietaryGoals: goals));
    await _persist(state.value!);
  }

  Future<void> clear() async {
    state = const AsyncValue.data(OnboardingDraft());
    await _isar.clearOnboardingData();
  }

  Future<void> _persist(OnboardingDraft draft) async {
    final data = OnboardingData(
      name: draft.name,
      county: draft.county,
      region: draft.country,
      subRegion: draft.subRegion,
      dailyBudget: draft.budget,
      dietaryGoals: draft.dietaryGoals,
    );
    await _isar.saveOnboardingData(data);
  }
}
