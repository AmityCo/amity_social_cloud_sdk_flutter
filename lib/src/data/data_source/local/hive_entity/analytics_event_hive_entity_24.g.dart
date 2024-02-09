// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_event_hive_entity_24.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnalyticsEventHiveEntityAdapter
    extends TypeAdapter<AnalyticsEventHiveEntity> {
  @override
  final int typeId = 24;

  @override
  AnalyticsEventHiveEntity read(BinaryReader reader) {
    return AnalyticsEventHiveEntity();
  }

  @override
  void write(BinaryWriter writer, AnalyticsEventHiveEntity obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalyticsEventHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
