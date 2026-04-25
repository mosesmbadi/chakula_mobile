import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealHistoryFilter {
  final String? region;
  final String? subRegion;

  const MealHistoryFilter({this.region, this.subRegion});

  MealHistoryFilter copyWith({String? region, String? subRegion, bool clearRegion = false, bool clearSubRegion = false}) {
    return MealHistoryFilter(
      region: clearRegion ? null : (region ?? this.region),
      subRegion: clearSubRegion ? null : (subRegion ?? this.subRegion),
    );
  }

  bool get isEmpty => region == null && subRegion == null;
}

final mealHistoryFilterProvider = StateProvider<MealHistoryFilter>(
  (_) => const MealHistoryFilter(),
);
