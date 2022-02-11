import 'package:amity_sdk/data/data_source/local/hive_entity/account_hive_entity.dart';

abstract class AccountDbAdapter {
  void saveAccountEntity(AccountHiveEntity entity);
  AccountHiveEntity getAccountEntity();
}
