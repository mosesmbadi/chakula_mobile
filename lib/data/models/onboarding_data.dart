import 'package:isar/isar.dart';

part 'onboarding_data.g.dart';

@collection
class OnboardingData {
  @id
  int isarId = 0; // singleton – always use id 0

  String name;
  String region;
  String subRegion;
  int dailyBudget;
  List<String> dietaryGoals;

  OnboardingData({
    this.name = '',
    this.region = 'kenya',
    this.subRegion = 'nairobi',
    this.dailyBudget = 200,
    this.dietaryGoals = const ['high-fibre'],
  });
}
