// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive_entity_5.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveEntityAdapter extends TypeAdapter<PostHiveEntity> {
  @override
  final int typeId = 5;

  @override
  PostHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveEntity();
  }

  @override
  void write(BinaryWriter writer, PostHiveEntity obj) {
    writer.writeByte(0);
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
