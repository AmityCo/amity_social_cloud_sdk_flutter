// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_category_hive_12.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommunityCategoryHiveEntityAdapter
    extends TypeAdapter<CommunityCategoryHiveEntity> {
  @override
  final int typeId = 12;

  @override
  CommunityCategoryHiveEntity read(BinaryReader reader) {
    return CommunityCategoryHiveEntity();
  }

  @override
  void write(BinaryWriter writer, CommunityCategoryHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityCategoryHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
