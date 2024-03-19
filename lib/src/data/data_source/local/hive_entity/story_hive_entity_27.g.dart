// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_hive_entity_27.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryHiveEntityAdapter extends TypeAdapter<StoryHiveEntity> {
  @override
  final int typeId = 27;

  @override
  StoryHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryHiveEntity();
  }

  @override
  void write(BinaryWriter writer, StoryHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
