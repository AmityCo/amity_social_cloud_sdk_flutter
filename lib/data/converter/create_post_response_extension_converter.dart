import 'package:amity_sdk/data/data_source/local/hive_entity/feed_hive_entity_10.dart';
import 'package:amity_sdk/data/response/response.dart';

extension CreatePostResponseExtension on CreatePostResponse {
  FeedHiveEntity convertToFeedHiveEntity() => FeedHiveEntity()
    ..id = '$hashCode'
    ..postIds = posts.map((e) => e.postId).toList()
    ..nextToken = paging?.next;
}
