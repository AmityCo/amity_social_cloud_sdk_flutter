import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/account_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/account_hive_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountDbAdapterImpl extends AccountDbAdapter {
  final HiveDbClient dbClient;

  AccountDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<AccountDbAdapterImpl> init() async {
    box = await Hive.openBox<AccountHiveEntity>('account_db');
    return this;
  }

  @override
  AccountHiveEntity getAccountEntity() {
    return box.getAt(0);
  }

  @override
  void saveAccountEntity(AccountHiveEntity entity) {
    box.add(entity);
  }
}
