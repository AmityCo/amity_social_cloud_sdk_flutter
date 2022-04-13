// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_hive_entity_8.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReactionHiveEntityAdapter extends TypeAdapter<ReactionHiveEntity> {
  @override
  final int typeId = 8;

  @override
  ReactionHiveEntity read(BinaryReader reader) {
    return ReactionHiveEntity();
  }

  @override
  void write(BinaryWriter writer, ReactionHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReactionHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
