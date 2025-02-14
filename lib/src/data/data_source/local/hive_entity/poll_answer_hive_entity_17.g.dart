// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_answer_hive_entity_17.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PollAnswerHiveEntityAdapter extends TypeAdapter<PollAnswerHiveEntity> {
  @override
  final int typeId = 17;

  @override
  PollAnswerHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PollAnswerHiveEntity(
      id: fields[0] as String?,
      data: fields[1] as String?,
      dataType: fields[2] as String?,
      voteCount: fields[3] as int?,
      isVotedByUser: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PollAnswerHiveEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.dataType)
      ..writeByte(3)
      ..write(obj.voteCount)
      ..writeByte(4)
      ..write(obj.isVotedByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollAnswerHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
