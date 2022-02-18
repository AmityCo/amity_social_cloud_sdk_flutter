import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data_source/data_source.dart';
import 'package:amity_sdk/domain/domain.dart';

abstract class AccountRepo {
  AccountHiveEntity getAccount();
  Stream<AccountHiveEntity> listenAccount();
}
