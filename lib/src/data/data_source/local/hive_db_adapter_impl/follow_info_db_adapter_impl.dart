import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class FollowInfoDbAdapterImpl extends FollowInfoDbAdapter {
  final DBClient dbClient;

  FollowInfoDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FollowInfoDbAdapter> init() async {
    Hive.registerAdapter(FollowInfoHiveEntityAdapter(), override: true);
    box = await Hive.openBox<FollowInfoHiveEntity>('follow_info_db');
    return this;
  }

  @override
  FollowInfoHiveEntity? getFollowInfo(String id) {
    return box.get(id);
  }

  @override
  Future saveFollowInfo(FollowInfoHiveEntity entity) async {
    await box.put(entity.userId, entity);
  }

  @override
  Stream<FollowInfoHiveEntity> stream(String id) {
    return box.watch(key: id).map((event) => event.value);
  }
}
