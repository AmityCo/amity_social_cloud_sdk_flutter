import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';
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
