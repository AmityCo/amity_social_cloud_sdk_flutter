// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_feed_hive_13.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommunityFeedHiveEntityAdapter
    extends TypeAdapter<CommunityFeedHiveEntity> {
  @override
  final int typeId = 13;

  @override
  CommunityFeedHiveEntity read(BinaryReader reader) {
    return CommunityFeedHiveEntity();
  }

  @override
  void write(BinaryWriter writer, CommunityFeedHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityFeedHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
