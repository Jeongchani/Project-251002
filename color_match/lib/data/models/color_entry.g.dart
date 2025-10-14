// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorEntryAdapter extends TypeAdapter<ColorEntry> {
  @override
  final int typeId = 1;

  @override
  ColorEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorEntry(
      name: fields[0] as String,
      hex: fields[1] as String,
      group: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ColorEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.hex)
      ..writeByte(2)
      ..write(obj.group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
