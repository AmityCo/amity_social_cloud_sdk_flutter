// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_target_hive_entity_28.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryTargetHiveEntityAdapter extends TypeAdapter<StoryTargetHiveEntity> {
  @override
  final int typeId = 28;

  @override
  StoryTargetHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryTargetHiveEntity();
  }

  @override
  void write(BinaryWriter writer, StoryTargetHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryTargetHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
