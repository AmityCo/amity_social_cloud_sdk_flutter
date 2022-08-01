import 'package:amity_sdk/src/data/data.dart';
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
  FollowHiveEntity getFollowEntiry(String id) {
    return box.get(id);
  }

  @override
  Future saveFollowEntity(FollowHiveEntity entity) async {
    await box.put('${entity.sourceUserId}_${entity.targetUserId}', entity);
  }

  @override
  Stream<FollowHiveEntity> stream(String id) {
    return box.watch(key: id).map((event) => event.value);
  }
}
