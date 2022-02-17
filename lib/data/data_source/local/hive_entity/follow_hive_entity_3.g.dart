// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_hive_entity_3.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowHiveEntityAdapter extends TypeAdapter<FollowHiveEntity> {
  @override
  final int typeId = 3;

  @override
  FollowHiveEntity read(BinaryReader reader) {
    return FollowHiveEntity();
  }

  @override
  void write(BinaryWriter writer, FollowHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
