// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_entity_1.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveEntityAdapter extends TypeAdapter<UserHiveEntity> {
  @override
  final int typeId = 1;

  @override
  UserHiveEntity read(BinaryReader reader) {
    return UserHiveEntity();
  }

  @override
  void write(BinaryWriter writer, UserHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
