import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [FeedRepository] to get feeds
class FeedRepository {
  /// Get Gloabl Feed
  AmityGlobalFeedQuery getGlobalFeed() {
    return AmityGlobalFeedQuery(serviceLocator());
  }

  /// Get User Feed
  UserFeedQueryBuilder getUserFeed(String userId) {
    return UserFeedQueryBuilder(serviceLocator(), userId);
  }

  /// Get Community Feed
  CommunityFeedQueryBuilder getCommunityFeed(String communityId) {
    return CommunityFeedQueryBuilder(serviceLocator(), communityId);
  }
}
