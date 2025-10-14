import 'package:hive/hive.dart';
part 'wear_log.g.dart';

@HiveType(typeId: 7)
class WearLog {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final String? topHex;
  @HiveField(2)
  final String? bottomHex;
  @HiveField(3)
  final String? scarfHex;
  @HiveField(4)
  final String? shoesHex;
  @HiveField(5)
  final String? hatHex;

  const WearLog({required this.date, this.topHex, this.bottomHex, this.scarfHex, this.shoesHex, this.hatHex});
}
