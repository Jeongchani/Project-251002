import 'package:hive/hive.dart';
part 'color_entry.g.dart';

@HiveType(typeId: 1)
class ColorEntry {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String hex;
  @HiveField(2)
  final String group;
  const ColorEntry({required this.name, required this.hex, required this.group});
}
