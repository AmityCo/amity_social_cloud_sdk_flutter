import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_feed_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_feed_hive_13.dart';
import 'package:hive/hive.dart';

class CommunityFeedDbAdapterImpl extends CommunityFeedDbAdapter {
  final DBClient dbClient;

  CommunityFeedDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommunityFeedDbAdapterImpl> init() async {
    Hive.registerAdapter(CommunityFeedHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommunityFeedHiveEntity>('community_feed_db');
    return this;
  }

  @override
  CommunityFeedHiveEntity getCommunityFeedEntity(String id) {
    return box.get(id);
  }

  @override
  Future saveCommunityFeedEntity(CommunityFeedHiveEntity entity) async {
    await box.put(entity.feedId, entity);
  }
}
