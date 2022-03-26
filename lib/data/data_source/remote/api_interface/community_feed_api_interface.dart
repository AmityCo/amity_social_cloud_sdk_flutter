import 'package:amity_sdk/core/model/api_request/get_community_feed_request.dart';
import 'package:amity_sdk/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/data/response/response.dart';

abstract class CommunityFeedApiInterface {
  Future<CreatePostResponse> getCommunityFeed(GetCommunityFeedRequest request);
}
