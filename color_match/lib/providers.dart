import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/colors_dict_loader.dart';
import 'data/models/color_entry.dart';
import 'data/models/user_pref.dart';
import 'data/repositories/local_db.dart';

LocalDb? _db;

final localDbProvider = Provider<LocalDb>((ref)=> _db!);

Future<void> initAppServices() async {
  final db = LocalDb();
  await db.init();
  final loaded = await loadStandardColors();
  await db.seedColors(loaded);
  await db.ensureUserPref();
  _db = db;
}

// Colors
final standardColorsProvider = FutureProvider<List<ColorEntry>>((ref) async {
  final db = ref.read(localDbProvider);
  return db.colorDict.values.toList();
});

// User Pref (tone etc.)
final userPrefProvider = StateNotifierProvider<UserPrefController, UserPref>((ref){
  final db = ref.read(localDbProvider);
  final pref = db.user.get('pref', defaultValue: const UserPref());
  return UserPrefController(db, pref ?? const UserPref());
});

class UserPrefController extends StateNotifier<UserPref>{
  final LocalDb db;
  UserPrefController(this.db, UserPref initial): super(initial);
  Future<void> setTone(PersonalTone tone) async {
    state = state.copyWith(tone: tone);
    await db.user.put('pref', state);
  }
}

// Today's recommendation
final todayRecommendationProvider = FutureProvider<List<Color>>((ref) async {
  final entries = await ref.watch(standardColorsProvider.future);
  final pref = ref.watch(userPrefProvider);
  final dict = entries.map((e)=> hexToColor(e.hex)).toList();

  List<Color> filterByTone(List<Color> src, PersonalTone t){
    if(t == PersonalTone.cool){
      return src.where((c){
        final h = HSLColor.fromColor(c).hue;
        return h>=180 && h<=300; // blue ~ purple
      }).toList();
    } else if(t == PersonalTone.warm){
      return src.where((c){
        final h = HSLColor.fromColor(c).hue;
        return h<90 || (h>=90 && h<=150) || h>330; // yellow/orange/olive/red
      }).toList();
    } else {
      return src.where((c){
        final hsl = HSLColor.fromColor(c);
        return hsl.saturation<0.18 || (hsl.hue>=190 && hsl.hue<=230); // neutrals + soft blues
      }).toList();
    }
  }
  final cand = filterByTone(dict, pref.tone);
  final now = DateTime.now();
  final seed = now.year*1000 + (now.difference(DateTime(now.year,1,1)).inDays+1);
  final rng = Random(seed);
  cand.shuffle(rng);
  return cand.take(6).toList();
});
