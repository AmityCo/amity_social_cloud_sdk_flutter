// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data_hive_entity_7.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostChildDataHiveEntityAdapter
    extends TypeAdapter<PostChildDataHiveEntity> {
  @override
  final int typeId = 7;

  @override
  PostChildDataHiveEntity read(BinaryReader reader) {
    return PostChildDataHiveEntity();
  }

  @override
  void write(BinaryWriter writer, PostChildDataHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostChildDataHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
