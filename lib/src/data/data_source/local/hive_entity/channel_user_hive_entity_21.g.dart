// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_user_hive_entity_21.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChannelUserHiveEntityAdapter extends TypeAdapter<ChannelUserHiveEntity> {
  @override
  final int typeId = 21;

  @override
  ChannelUserHiveEntity read(BinaryReader reader) {
    return ChannelUserHiveEntity();
  }

  @override
  void write(BinaryWriter writer, ChannelUserHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelUserHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
