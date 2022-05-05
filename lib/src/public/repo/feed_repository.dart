import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/query_builder/feed/community_feed_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/feed/global_feed_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/feed/user_feed_query_builder.dart';

class FeedRepository {
  AmityGlobalFeedQuery getGlobalFeed() {
    return AmityGlobalFeedQuery(serviceLocator());
  }

  UserFeedQueryBuilder getUserFeed(String userId) {
    return UserFeedQueryBuilder(serviceLocator(), userId);
  }

  CommunityFeedQueryBuilder getCommunityFeed(String communityId) {
    return CommunityFeedQueryBuilder(serviceLocator(), communityId);
  }
}
