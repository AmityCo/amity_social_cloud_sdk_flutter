// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: avoid_single_cascade_in_expression_statements

part of 'video_file_id_hive_entity_11.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoFileIdHiveEntityAdapter extends TypeAdapter<VideoFileIdHiveEntity> {
  @override
  final int typeId = 11;

  @override
  VideoFileIdHiveEntity read(BinaryReader reader) {
    return VideoFileIdHiveEntity();
  }

  @override
  void write(BinaryWriter writer, VideoFileIdHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoFileIdHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
