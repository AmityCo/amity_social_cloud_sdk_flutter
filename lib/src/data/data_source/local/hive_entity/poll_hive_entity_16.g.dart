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
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PollHiveEntity(
      id: fields[0] as String?,
      pollId: fields[1] as String?,
      userId: fields[2] as String?,
      question: fields[3] as String?,
      answers: (fields[4] as List?)?.cast<PollAnswerHiveEntity>(),
      answerType: fields[5] as String?,
      status: fields[6] as String?,
      closedAt: fields[7] as DateTime?,
      isDeleted: fields[8] as bool?,
      isVoted: fields[9] as bool?,
      createdAt: fields[10] as DateTime?,
      updatedAt: fields[11] as DateTime?,
      closeIn: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PollHiveEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pollId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.answers)
      ..writeByte(5)
      ..write(obj.answerType)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.closedAt)
      ..writeByte(8)
      ..write(obj.isDeleted)
      ..writeByte(9)
      ..write(obj.isVoted)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.closeIn);
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
