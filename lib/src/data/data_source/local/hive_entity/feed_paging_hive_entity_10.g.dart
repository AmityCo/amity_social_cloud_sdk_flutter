// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_paging_hive_entity_10.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedPagingHiveEntityAdapter extends TypeAdapter<FeedPagingHiveEntity> {
  @override
  final int typeId = 10;

  @override
  FeedPagingHiveEntity read(BinaryReader reader) {
    return FeedPagingHiveEntity();
  }

  @override
  void write(BinaryWriter writer, FeedPagingHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPagingHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
