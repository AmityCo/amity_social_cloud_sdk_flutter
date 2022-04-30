import 'package:amity_sdk/src/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/src/data/response/response.dart';

abstract class UserFeedApiInterface {
  Future<CreatePostResponse> getUserFeed(GetUserFeedRequest request);
}
