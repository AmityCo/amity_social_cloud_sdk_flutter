// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_settings_hive_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatSettingsHiveEntityAdapter
    extends TypeAdapter<ChatSettingsHiveEntity> {
  @override
  final int typeId = 38;

  @override
  ChatSettingsHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatSettingsHiveEntity()
      ..settingId = fields[0] as String
      ..enabled = fields[1] as bool?
      ..isAllowMentionedChannelEnabled = fields[2] as bool?
      ..messagePreviewSetting = fields[3] as String?
      ..createdAt = fields[4] as DateTime?
      ..updatedAt = fields[5] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, ChatSettingsHiveEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.settingId)
      ..writeByte(1)
      ..write(obj.enabled)
      ..writeByte(2)
      ..write(obj.isAllowMentionedChannelEnabled)
      ..writeByte(3)
      ..write(obj.messagePreviewSetting)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatSettingsHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
