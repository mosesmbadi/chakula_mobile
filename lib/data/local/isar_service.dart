import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/onboarding_data.dart';
import '../models/meal_history_item.dart';

class IsarService {
  static Future<Isar>? _sharedDb;

  IsarService() {
    _sharedDb ??= _openDb();
  }

  static Future<void> initialize() async {
    _sharedDb ??= _openDb();
    await _sharedDb;
  }

  static Future<Isar> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [OnboardingDataSchema, MealHistoryItemSchema],
      directory: dir.path,
    );
  }

  Future<Isar> get _db => _sharedDb!;

  Future<void> saveOnboardingData(OnboardingData data) async {
    final isar = await _db;
    data.id = 1;
    await isar.writeTxn(() async {
      await isar.onboardingDatas.put(data);
    });
  }

  Future<OnboardingData?> getOnboardingData() async {
    final isar = await _db;
    return isar.onboardingDatas.get(1);
  }

  Future<void> clearOnboardingData() async {
    final isar = await _db;
    await isar.writeTxn(() async {
      isar.onboardingDatas.clear();
    });
  }

  // --- Meal History Caching ---

  Future<void> cacheMealHistory(List<MealHistoryItem> meals) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.mealHistoryItems.putAll(meals);
    });
  }

  Future<List<MealHistoryItem>> getCachedMealHistory({
    String? region,
    String? subRegion,
    int limit = 20,
    int offset = 0,
  }) async {
    final isar = await _db;
    var query = isar.mealHistoryItems.where();

    if (region != null && region.isNotEmpty && subRegion != null && subRegion.isNotEmpty) {
      return query
          .filter()
          .regionEqualTo(region, caseSensitive: false)
          .subRegionEqualTo(subRegion, caseSensitive: false)
          .sortByEatenAtDesc()
          .offset(offset)
          .limit(limit)
          .findAll();
    } else if (region != null && region.isNotEmpty) {
      return query
          .filter()
          .regionEqualTo(region, caseSensitive: false)
          .sortByEatenAtDesc()
          .offset(offset)
          .limit(limit)
          .findAll();
    }

    return query.sortByEatenAtDesc().offset(offset).limit(limit).findAll();
  }

  Future<void> clearMealHistoryCache() async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.mealHistoryItems.clear();
    });
  }
}
