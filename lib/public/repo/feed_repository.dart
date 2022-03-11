import 'package:amity_sdk/core/service_locator/service_locator.dart';
import 'package:amity_sdk/public/query_builder/feed/global_feed_query_builder.dart';

class FeedRepository {
  AmityGlobalFeedQuery getGlobalFeed() {
    return AmityGlobalFeedQuery(serviceLocator());
  }
}
