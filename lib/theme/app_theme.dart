import 'package:hive/hive.dart';

import '../models/advance_entry.dart';
import '../models/work_day.dart';

class StorageService {
  static late final Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('payday_box');
  }

  static List<WorkDay> loadWorkDays() {
    final raw = _box.get('work_days', defaultValue: <Map<String, dynamic>>[]);
    if (raw is! List) {
      return [];
    }

    return raw.map((item) {
      return WorkDay.fromJson(Map<String, dynamic>.from(item as Map));
    }).toList();
  }

  static Future<void> saveWorkDays(List<WorkDay> workDays) async {
    await _box.put(
      'work_days',
      workDays.map((day) => day.toJson()).toList(),
    );
  }

  static List<AdvanceEntry> loadAdvances() {
    final raw = _box.get('advances', defaultValue: <Map<String, dynamic>>[]);
    if (raw is! List) {
      return [];
    }

    return raw.map((item) {
      return AdvanceEntry.fromJson(Map<String, dynamic>.from(item as Map));
    }).toList();
  }

  static Future<void> saveAdvances(List<AdvanceEntry> advances) async {
    await _box.put(
      'advances',
      advances.map((entry) => entry.toJson()).toList(),
    );
  }
}
