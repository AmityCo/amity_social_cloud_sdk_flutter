// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: avoid_single_cascade_in_expression_statements

part of 'post_hive_entity_5.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveEntityAdapter extends TypeAdapter<PostHiveEntity> {
  @override
  final int typeId = 5;

  @override
  PostHiveEntity read(BinaryReader reader) {
    return PostHiveEntity();
  }

  @override
  void write(BinaryWriter writer, PostHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
