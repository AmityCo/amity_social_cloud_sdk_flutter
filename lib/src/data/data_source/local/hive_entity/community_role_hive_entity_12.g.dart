// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_role_hive_entity_12.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommunityRoleHiveEntityAdapter
    extends TypeAdapter<CommunityRoleHiveEntity> {
  @override
  final int typeId = 12;

  @override
  CommunityRoleHiveEntity read(BinaryReader reader) {
    return CommunityRoleHiveEntity();
  }

  @override
  void write(BinaryWriter writer, CommunityRoleHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityRoleHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
