import 'package:amity_sdk/src/data/data_source/local/hive_entity/account_hive_entity_0.dart';

abstract class AccountDbAdapter {
  void saveAccountEntity(AccountHiveEntity entity);

  AccountHiveEntity getAccountEntity();

  Stream<AccountHiveEntity> listenAccountEntity();
}
