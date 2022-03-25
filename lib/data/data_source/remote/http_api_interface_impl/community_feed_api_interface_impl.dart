import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/get_community_feed_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/community_feed_api_interface.dart';
import 'package:dio/dio.dart';

class CommunityFeedApiInterfaceImpl extends CommunityFeedApiInterface {
  CommunityFeedApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getCommunityFeed(
      GetCommunityFeedRequest request) async {
    try {
      final data = await httpApiClient()
          .get(COMMUNITY_FEED_V3_URL, queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
