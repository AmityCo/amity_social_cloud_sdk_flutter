import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class AccountDbAdapterImpl extends AccountDbAdapter {
  final DBClient dbClient;

  AccountDbAdapterImpl({required this.dbClient});
  late Box<AccountHiveEntity> box;
  Future<AccountDbAdapterImpl> init() async {
    Hive.registerAdapter(AccountHiveEntityAdapter(), override: true);
    box = await Hive.openBox<AccountHiveEntity>('account_db');
    return this;
  }

  @override
  Stream<AccountHiveEntity?> listenAccountEntity(String userId) {
    //first value is always null regarding this issue
    //https://github.com/hivedb/hive/issues/20
    return box.watch(key: userId).map((event) {
      if (event.value != null && event.value is AccountHiveEntity) {
        return event.value as AccountHiveEntity;
      } else {
        return getAccountEntity(userId);
      }
    });
  }

  @override
  AccountHiveEntity? getAccountEntity(String userId) {
    return box.get(userId);
  }

  @override
  Future saveAccountEntity(AccountHiveEntity entity) async {
    await box.clear();
    await box.put(entity.userId, entity);
  }

  @override
  Stream<AccountHiveEntity?> listenAccounts() {
    return box.watch().map<AccountHiveEntity>((event) => event.value);
  }

  @override
  List<AccountHiveEntity> getAccounts() {
    return box.values.toList();
  }
}
