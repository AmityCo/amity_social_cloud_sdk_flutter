import 'package:amity_sdk/data/data_source/data_source.dart';

abstract class AccountRepo {
  AccountHiveEntity getAccount();
  Stream<AccountHiveEntity> listenAccount();
}
