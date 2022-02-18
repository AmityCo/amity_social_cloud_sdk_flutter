import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/follow_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/follow_hive_entity_3.dart';
import 'package:hive/hive.dart';

class FollowDbAdapterImpl extends FollowDbAdapter {
  final DBClient dbClient;

  FollowDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FollowDbAdapter> init() async {
    Hive.registerAdapter(FollowHiveEntityAdapter());
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
