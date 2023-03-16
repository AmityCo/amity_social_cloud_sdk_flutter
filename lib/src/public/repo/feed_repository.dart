import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [FeedRepository] to get feeds
class FeedRepository {
  /* begin_public_function 
  id: feed.query.global_feed
  */
  /// Get Gloabl Feed
  AmityGlobalFeedQuery getGlobalFeed() {
    return AmityGlobalFeedQuery(serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: feed.query.user_feed
  */
  /// Get User Feed
  UserFeedQueryBuilder getUserFeed(String userId) {
    return UserFeedQueryBuilder(serviceLocator(), userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: feed.query.community_feed
  */
  /// Get Community Feed
  CommunityFeedQueryBuilder getCommunityFeed(String communityId) {
    return CommunityFeedQueryBuilder(serviceLocator(), communityId);
  }
  /* end_public_function */
}
