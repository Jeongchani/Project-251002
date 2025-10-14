// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wear_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WearLogAdapter extends TypeAdapter<WearLog> {
  @override
  final int typeId = 7;

  @override
  WearLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WearLog(
      date: fields[0] as DateTime,
      topHex: fields[1] as String?,
      bottomHex: fields[2] as String?,
      scarfHex: fields[3] as String?,
      shoesHex: fields[4] as String?,
      hatHex: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WearLog obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.topHex)
      ..writeByte(2)
      ..write(obj.bottomHex)
      ..writeByte(3)
      ..write(obj.scarfHex)
      ..writeByte(4)
      ..write(obj.shoesHex)
      ..writeByte(5)
      ..write(obj.hatHex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WearLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
