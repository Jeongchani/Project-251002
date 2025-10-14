import 'package:hive/hive.dart';
part 'user_pref.g.dart';

@HiveType(typeId: 5)
enum PersonalTone { @HiveField(0) none, @HiveField(1) cool, @HiveField(2) warm }

@HiveType(typeId: 6)
class UserPref {
  @HiveField(0)
  final PersonalTone tone;
  @HiveField(1)
  final List<String> likedHexes;

  const UserPref({this.tone = PersonalTone.none, this.likedHexes = const []});

  UserPref copyWith({PersonalTone? tone, List<String>? likedHexes}) =>
    UserPref(tone: tone ?? this.tone, likedHexes: likedHexes ?? this.likedHexes);
}
