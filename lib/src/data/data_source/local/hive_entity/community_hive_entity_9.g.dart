// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: avoid_single_cascade_in_expression_statements

part of 'community_hive_entity_9.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommunityHiveEntityAdapter extends TypeAdapter<CommunityHiveEntity> {
  @override
  final int typeId = 9;

  @override
  CommunityHiveEntity read(BinaryReader reader) {
    return CommunityHiveEntity();
  }

  @override
  void write(BinaryWriter writer, CommunityHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
