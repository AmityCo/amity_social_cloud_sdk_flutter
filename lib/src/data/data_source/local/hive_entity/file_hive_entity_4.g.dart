// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_hive_entity_4.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileHiveEntityAdapter extends TypeAdapter<FileHiveEntity> {
  @override
  final int typeId = 4;

  @override
  FileHiveEntity read(BinaryReader reader) {
    return FileHiveEntity();
  }

  @override
  void write(BinaryWriter writer, FileHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
