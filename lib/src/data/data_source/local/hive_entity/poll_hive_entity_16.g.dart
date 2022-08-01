// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_hive_entity_16.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PollHiveEntityAdapter extends TypeAdapter<PollHiveEntity> {
  @override
  final int typeId = 16;

  @override
  PollHiveEntity read(BinaryReader reader) {
    return PollHiveEntity();
  }

  @override
  void write(BinaryWriter writer, PollHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
