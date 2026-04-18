import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/onboarding_data.dart';

class IsarService {
  late Future<Isar> _db;

  IsarService() {
    _db = _openDb();
  }

  Future<Isar> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [OnboardingDataSchema],
      directory: dir.path,
    );
  }

  Future<void> saveOnboardingData(OnboardingData data) async {
    final isar = await _db;
    data.id = 1; // Fixed ID so every save upserts the same record
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
}
