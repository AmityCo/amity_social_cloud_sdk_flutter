// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tombstone_hive_entity_22.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TombstoneHiveEntityAdapter extends TypeAdapter<TombstoneHiveEntity> {
  @override
  final int typeId = 22;

  @override
  TombstoneHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TombstoneHiveEntity();
  }

  @override
  void write(BinaryWriter writer, TombstoneHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TombstoneHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
