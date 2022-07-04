// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_member_paging_hive_entity_15.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommunityMemberPagingHiveEntityAdapter
    extends TypeAdapter<CommunityMemberPagingHiveEntity> {
  @override
  final int typeId = 15;

  @override
  CommunityMemberPagingHiveEntity read(BinaryReader reader) {
    return CommunityMemberPagingHiveEntity();
  }

  @override
  void write(BinaryWriter writer, CommunityMemberPagingHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityMemberPagingHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
