// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_hive_entity_20.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChannelHiveEntityAdapter extends TypeAdapter<ChannelHiveEntity> {
  @override
  final int typeId = 20;

  @override
  ChannelHiveEntity read(BinaryReader reader) {
    return ChannelHiveEntity();
  }

  @override
  void write(BinaryWriter writer, ChannelHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
