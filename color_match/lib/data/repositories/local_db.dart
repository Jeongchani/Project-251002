import 'package:hive_flutter/hive_flutter.dart';
import '../models/color_entry.dart';
import '../models/user_pref.dart';
import '../models/wear_log.dart';

class LocalDb {
  static const colorsBox = 'colors_box';
  static const userBox = 'user_box';
  static const wearBox = 'wear_box';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(ColorEntryAdapter());
    if (!Hive.isAdapterRegistered(5)) Hive.registerAdapter(PersonalToneAdapter());
    if (!Hive.isAdapterRegistered(6)) Hive.registerAdapter(UserPrefAdapter());
    if (!Hive.isAdapterRegistered(7)) Hive.registerAdapter(WearLogAdapter());

    await Hive.openBox<ColorEntry>(colorsBox);
    await Hive.openBox<UserPref>(userBox);
    await Hive.openBox<WearLog>(wearBox);
  }

  Box<ColorEntry> get colorDict => Hive.box<ColorEntry>(colorsBox);
  Future<void> seedColors(List<ColorEntry> items) async {
    if (colorDict.isEmpty) {
      for (final c in items) {
        await colorDict.add(c);
      }
    }
  }

  Box<UserPref> get user => Hive.box<UserPref>(userBox);
  Future<void> ensureUserPref() async {
    if (user.isEmpty) {
      await user.put('pref', const UserPref());
    }
  }

  Box<WearLog> get wears => Hive.box<WearLog>(wearBox);
  Future<void> upsertWear(WearLog log) async {
    final key = DateTime(log.date.year, log.date.month, log.date.day).toIso8601String();
    await wears.put(key, log);
  }
  WearLog? getWearByDate(DateTime date){
    final key = DateTime(date.year, date.month, date.day).toIso8601String();
    return wears.get(key);
  }
}
