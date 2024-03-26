import 'package:amity_sdk/src/data/data.dart';
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
  
  @override
  CommunityFeedHiveEntity getCommunityFeedByFeedType(String targetId, String feedType) {
    return box.values.firstWhere((element) => element.targetId == targetId && element.feedType == feedType);
  }
}
