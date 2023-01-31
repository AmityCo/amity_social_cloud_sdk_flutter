// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_hive_entity_6.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentHiveEntityAdapter extends TypeAdapter<CommentHiveEntity> {
  @override
  final int typeId = 6;

  @override
  CommentHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentHiveEntity();
  }

  @override
  void write(BinaryWriter writer, CommentHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
