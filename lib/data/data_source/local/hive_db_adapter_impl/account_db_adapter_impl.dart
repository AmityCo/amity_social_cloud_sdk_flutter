import 'package:amity_sdk/data/data.dart';
import 'package:hive/hive.dart';

class AccountDbAdapterImpl extends AccountDbAdapter {
  final DBClient dbClient;

  AccountDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<AccountDbAdapterImpl> init() async {
    Hive.registerAdapter(AccountHiveEntityAdapter());
    box = await Hive.openBox<AccountHiveEntity>('account_db');
    return this;
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
