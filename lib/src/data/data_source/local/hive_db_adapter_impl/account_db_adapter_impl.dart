import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class AccountDbAdapterImpl extends AccountDbAdapter {
  final DBClient dbClient;

  AccountDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<AccountDbAdapterImpl> init() async {
    Hive.registerAdapter(AccountHiveEntityAdapter(), override: true);
    box = await Hive.openBox<AccountHiveEntity>('account_db');
    return this;
  }

  @override
  Stream<AccountHiveEntity> listenAccountEntity() {
    return box.watch().map((event) => event.value as AccountHiveEntity);
  }

  @override
  AccountHiveEntity getAccountEntity() {
    return box.getAt(0);
  }

  @override
  void saveAccountEntity(AccountHiveEntity entity) async {
    await box.clear();
    await box.add(entity);
  }
}
