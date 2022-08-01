// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_hive_entity_0.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountHiveEntityAdapter extends TypeAdapter<AccountHiveEntity> {
  @override
  final int typeId = 0;

  @override
  AccountHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountHiveEntity(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      roles: (fields[2] as List?)?.cast<String>(),
      permissions: (fields[3] as List?)?.cast<String>(),
      displayName: fields[4] as String?,
      description: fields[5] as String?,
      avatarFileId: fields[6] as String?,
      avatarCustomUrl: fields[7] as String?,
      flagCount: fields[8] as int?,
      metadata: (fields[9] as Map?)?.cast<String, dynamic>(),
      isGlobalBan: fields[10] as bool?,
      createdAt: fields[11] as DateTime?,
      updatedAt: fields[12] as DateTime?,
      deviceId: fields[13] as String?,
      isActive: fields[14] as bool?,
      refreshToken: fields[15] as String?,
      accessToken: fields[16] as String?,
      lastInactiveChannelIdsQuery: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountHiveEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.roles)
      ..writeByte(3)
      ..write(obj.permissions)
      ..writeByte(4)
      ..write(obj.displayName)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.avatarFileId)
      ..writeByte(7)
      ..write(obj.avatarCustomUrl)
      ..writeByte(8)
      ..write(obj.flagCount)
      ..writeByte(9)
      ..write(obj.metadata)
      ..writeByte(10)
      ..write(obj.isGlobalBan)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.deviceId)
      ..writeByte(14)
      ..write(obj.isActive)
      ..writeByte(15)
      ..write(obj.refreshToken)
      ..writeByte(16)
      ..write(obj.accessToken)
      ..writeByte(17)
      ..write(obj.lastInactiveChannelIdsQuery);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
