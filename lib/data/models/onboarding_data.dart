import 'package:isar_community/isar.dart';

part 'onboarding_data.g.dart';

@collection
class OnboardingData {
  Id? id;

  String name;
  String county;
  String region;
  String subRegion;
  int dailyBudget;
  List<String> dietaryGoals;

  OnboardingData({
    this.id,
    this.name = '',
    this.county = 'Nairobi',
    this.region = 'kenya',
    this.subRegion = 'nairobi',
    this.dailyBudget = 200,
    this.dietaryGoals = const ['high-fibre'],
  });
}
