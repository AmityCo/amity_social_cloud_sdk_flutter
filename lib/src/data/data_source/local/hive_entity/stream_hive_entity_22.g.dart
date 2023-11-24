// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_hive_entity_22.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreamHiveEntityAdapter extends TypeAdapter<StreamHiveEntity> {
  @override
  final int typeId = 22;

  @override
  StreamHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreamHiveEntity();
  }

  @override
  void write(BinaryWriter writer, StreamHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
