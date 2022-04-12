import 'package:amity_sdk/data/data.dart';
import 'package:hive/hive.dart';

class UserDbAdapterImpl extends UserDbAdapter {
  final DBClient dbClient;

  UserDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<UserDbAdapterImpl> init() async {
    Hive.registerAdapter(UserHiveEntityAdapter(), override: true);
    box = await Hive.openBox<UserHiveEntity>('user_db');
    return this;
  }

  @override
  UserHiveEntity getUserEntity(String userId) {
    return box.get(userId);
  }

  @override
  Future saveUserEntity(UserHiveEntity entity) async {
    await box.put(entity.userId, entity);
  }
}
