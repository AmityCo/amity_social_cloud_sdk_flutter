// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data_hive_entity_19.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageDataHiveEntityAdapter extends TypeAdapter<MessageDataHiveEntity> {
  @override
  final int typeId = 19;

  @override
  MessageDataHiveEntity read(BinaryReader reader) {
    return MessageDataHiveEntity();
  }

  @override
  void write(BinaryWriter writer, MessageDataHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageDataHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
