// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pref.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPrefAdapter extends TypeAdapter<UserPref> {
  @override
  final int typeId = 6;

  @override
  UserPref read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPref(
      tone: fields[0] as PersonalTone,
      likedHexes: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserPref obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tone)
      ..writeByte(1)
      ..write(obj.likedHexes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPrefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PersonalToneAdapter extends TypeAdapter<PersonalTone> {
  @override
  final int typeId = 5;

  @override
  PersonalTone read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PersonalTone.none;
      case 1:
        return PersonalTone.cool;
      case 2:
        return PersonalTone.warm;
      default:
        return PersonalTone.none;
    }
  }

  @override
  void write(BinaryWriter writer, PersonalTone obj) {
    switch (obj) {
      case PersonalTone.none:
        writer.writeByte(0);
        break;
      case PersonalTone.cool:
        writer.writeByte(1);
        break;
      case PersonalTone.warm:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalToneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
