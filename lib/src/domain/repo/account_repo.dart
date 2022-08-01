import 'package:amity_sdk/src/data/data_source/data_source.dart';

abstract class AccountRepo {
  AccountHiveEntity? getAccount(String userId);
  Stream<AccountHiveEntity> listenAccount(String userId);
}
