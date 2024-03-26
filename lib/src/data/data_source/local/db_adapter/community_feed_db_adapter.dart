import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_feed_hive_13.dart';

abstract class CommunityFeedDbAdapter {
  Future saveCommunityFeedEntity(CommunityFeedHiveEntity entity);
  CommunityFeedHiveEntity getCommunityFeedEntity(String id);
  CommunityFeedHiveEntity getCommunityFeedByFeedType(String targetId , String feedType);
}
