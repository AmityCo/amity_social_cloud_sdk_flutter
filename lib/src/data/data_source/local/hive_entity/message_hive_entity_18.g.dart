// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_hive_entity_18.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageHiveEntityAdapter extends TypeAdapter<MessageHiveEntity> {
  @override
  final int typeId = 18;

  @override
  MessageHiveEntity read(BinaryReader reader) {
    return MessageHiveEntity();
  }

  @override
  void write(BinaryWriter writer, MessageHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
