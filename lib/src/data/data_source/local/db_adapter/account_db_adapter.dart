import 'package:amity_sdk/src/data/data_source/local/hive_entity/account_hive_entity_0.dart';

abstract class AccountDbAdapter {
  Future saveAccountEntity(AccountHiveEntity entity);

  AccountHiveEntity? getAccountEntity(String userId);

  Stream<AccountHiveEntity?> listenAccountEntity(String userId);

  Stream<AccountHiveEntity?> listenAccounts();

  List<AccountHiveEntity> getAccounts();
}
