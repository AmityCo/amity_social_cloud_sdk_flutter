import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/user_db_adapter.dart';
import 'package:hive/hive.dart';

class UserDbAdapterImpl extends UserDbAdapter {
  final DBClient dbClient;

  UserDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<UserDbAdapterImpl> init() async {
    Hive.registerAdapter(UserHiveEntityAdapter());
    box = await Hive.openBox<UserHiveEntity>('user_db');
    return this;
  }

  @override
  UserHiveEntity getUser(String userId) {
    return box.get(userId);
  }

  @override
  Future saveUser(UserHiveEntity entity) async {
    await box.put(entity.userId, entity);
  }
}
