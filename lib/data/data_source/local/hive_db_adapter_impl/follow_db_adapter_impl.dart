import 'package:amity_sdk/data/data.dart';
import 'package:hive/hive.dart';

class FollowDbAdapterImpl extends FollowDbAdapter {
  final DBClient dbClient;

  FollowDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FollowDbAdapter> init() async {
    Hive.registerAdapter(FollowHiveEntityAdapter(), override: true);
    box = await Hive.openBox<FollowHiveEntity>('follow_db');
    return this;
  }

  @override
  FollowHiveEntity getFollowEntiry(String userId) {
    return box.get(userId);
  }

  @override
  Future saveFollowEntity(FollowHiveEntity entity) async {
    await box.put(entity.sourceUserId, entity);
  }
}
