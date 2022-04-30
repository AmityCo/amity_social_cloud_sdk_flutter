import 'package:amity_sdk/src/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/src/data/response/response.dart';

abstract class GlobalFeedApiInterface {
  Future<CreatePostResponse> getGlobalFeed(GetGlobalFeedRequest request);
}
