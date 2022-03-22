// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_hive_entity_10.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedHiveEntityAdapter extends TypeAdapter<FeedHiveEntity> {
  @override
  final int typeId = 10;

  @override
  FeedHiveEntity read(BinaryReader reader) {
    return FeedHiveEntity();
  }

  @override
  void write(BinaryWriter writer, FeedHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
