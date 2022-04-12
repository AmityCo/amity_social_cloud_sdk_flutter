import 'package:amity_sdk/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/data/response/response.dart';

abstract class UserFeedApiInterface {
  Future<CreatePostResponse> getUserFeed(GetUserFeedRequest request);
}
