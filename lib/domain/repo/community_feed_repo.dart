import 'package:amity_sdk/core/model/api_request/get_community_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/domain.dart';

abstract class CommunityFeedRepo {
  Future<Tuple2<List<AmityPost>, String>> getCommunityFeed(
      GetCommunityFeedRequest request);
}
