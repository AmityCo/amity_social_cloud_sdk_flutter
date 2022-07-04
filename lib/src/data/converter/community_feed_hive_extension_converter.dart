import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_feed_hive_13.dart';
import 'package:amity_sdk/src/domain/model/community/amity_community_feed.dart';

extension CommunityFeedHiveExtension on CommunityFeedHiveEntity {
  AmityCommunityFeed convertToAmityCommunityFeed() {
    return AmityCommunityFeed()
      ..feedId = feedId
      ..feedType = feedType
      ..targetId = targetId
      ..targetType = AmityPostTargetTypeExtension.enumOf(targetType!)
      ..postCount = postCount;
  }
}
