import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/follow_info_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/follow_info_hive_entity_2.dart';
import 'package:hive/hive.dart';

class FollowInfoDbAdapterImpl extends FollowInfoDbAdapter {
  final DBClient dbClient;

  FollowInfoDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FollowInfoDbAdapter> init() async {
    Hive.registerAdapter(FollowInfoHiveEntityAdapter());
    box = await Hive.openBox<FollowInfoHiveEntity>('follow_info_db');
    return this;
  }

  @override
  FollowInfoHiveEntity getFollowInfo(String userId) {
    return box.get(userId);
  }

  @override
  Future saveFollowInfo(FollowInfoHiveEntity entity) async {
    await box.put(entity.userId, entity);
  }
}
