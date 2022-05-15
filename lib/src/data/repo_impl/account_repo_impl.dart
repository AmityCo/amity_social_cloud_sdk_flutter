import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/repo/account_repo.dart';

class AccountRepoImpl extends AccountRepo {
  final AccountDbAdapter accountDbAdapter;
  AccountRepoImpl({required this.accountDbAdapter});

  @override
  AccountHiveEntity getAccount() {
    return accountDbAdapter.getAccountEntity();
  }

  @override
  Stream<AccountHiveEntity> listenAccount() {
    throw accountDbAdapter.listenAccountEntity();
  }
}
