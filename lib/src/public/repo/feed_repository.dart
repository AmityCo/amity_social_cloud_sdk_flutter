import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk/src/public/query_builder/feed/feed_get_qurey_builder.dart';

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
  id: feed.query.custom_ranking_global_feed
  */
  /// Get Custom Ranking
  AmityCustomRankingGlobalFeedQuery getCustomRankingGlobalFeed() {
    return AmityCustomRankingGlobalFeedQuery(serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: feed.query.user_feed
  */
  /// Get User Feed
  AmityFeedGetQureyBuilder getUserFeed(String userId) {
    return AmityFeedGetTargetSelector( useCase: serviceLocator()).targetUser(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: feed.query.community_feed
  */
  /// Get Community Feed
  AmityFeedGetQureyBuilder getCommunityFeed(String communityId) {
    return AmityFeedGetTargetSelector( useCase: serviceLocator()).targetCommunity(communityId);
  }
  /* end_public_function */
}
