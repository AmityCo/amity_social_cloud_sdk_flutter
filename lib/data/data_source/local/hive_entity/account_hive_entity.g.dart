// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_hive_entity_0.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountHiveEntityAdapter extends TypeAdapter<AccountHiveEntity> {
  @override
  final int typeId = 0;

  @override
  AccountHiveEntity read(BinaryReader reader) {
    return AccountHiveEntity();
  }

  @override
  void write(BinaryWriter writer, AccountHiveEntity obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
