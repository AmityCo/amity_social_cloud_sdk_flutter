import 'package:amity_sdk/src/core/model/api_request/get_community_feed_request.dart';
import 'package:amity_sdk/src/data/response/response.dart';

abstract class CommunityFeedApiInterface {
  Future<CreatePostResponse> getCommunityFeed(GetCommunityFeedRequest request);
}
