import 'package:amity_sdk/src/data/data_source/data_source.dart';

abstract class AccountRepo {
  AccountHiveEntity getAccount();
  Stream<AccountHiveEntity> listenAccount();
}
