// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveEntityAdapter extends TypeAdapter<PostHiveEntity> {
  @override
  final int typeId = 0;

  @override
  PostHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveEntity()..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, PostHiveEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
