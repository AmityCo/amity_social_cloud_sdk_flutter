import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_feed_hive_13.dart';
import 'package:amity_sdk/src/data/response/response.dart';

extension CommunityFeedResponseExtension on CommunityFeedResponse {
  CommunityFeedHiveEntity convertToCommunityFeedHiveEntity() {
    return CommunityFeedHiveEntity()
      ..feedId = feedId
      ..feedType = feedType
      ..targetId = targetId
      ..targetType = targetType
      ..postCount = postCount;
  }
}
