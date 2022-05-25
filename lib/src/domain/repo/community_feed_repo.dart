import 'package:amity_sdk/src/core/model/api_request/get_community_feed_request.dart';
import 'package:amity_sdk/src/core/utils/tuple.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommunityFeedRepo {
  Future<Tuple2<List<AmityPost>, String>> getCommunityFeed(
      GetCommunityFeedRequest request);
}
