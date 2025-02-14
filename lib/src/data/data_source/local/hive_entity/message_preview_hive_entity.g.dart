// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_preview_hive_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessagePreviewHiveEntityAdapter
    extends TypeAdapter<MessagePreviewHiveEntity> {
  @override
  final int typeId = 37;

  @override
  MessagePreviewHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessagePreviewHiveEntity(
      messagePreviewId: fields[0] as String?,
      dataType: fields[1] as String?,
      data: fields[2] as MessageDataHiveEntity?,
      channelId: fields[3] as String?,
      subChannelId: fields[4] as String?,
      subChannelName: fields[5] as String?,
      subChannelUpdatedAt: fields[6] as DateTime?,
      creatorId: fields[7] as String?,
      isDeleted: fields[8] as bool?,
      segment: fields[9] as int?,
      createdAt: fields[10] as DateTime?,
      updatedAt: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MessagePreviewHiveEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.messagePreviewId)
      ..writeByte(1)
      ..write(obj.dataType)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.channelId)
      ..writeByte(4)
      ..write(obj.subChannelId)
      ..writeByte(5)
      ..write(obj.subChannelName)
      ..writeByte(6)
      ..write(obj.subChannelUpdatedAt)
      ..writeByte(7)
      ..write(obj.creatorId)
      ..writeByte(8)
      ..write(obj.isDeleted)
      ..writeByte(9)
      ..write(obj.segment)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessagePreviewHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
