// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class CommunityFeedApiInterfaceImpl extends CommunityFeedApiInterface {
  CommunityFeedApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getCommunityFeed(
      GetCommunityFeedRequest request) async {
    try {
      final data = await httpApiClient().get(
          COMMUNITY_FEED_V3_URL + '/${request.communityId}',
          queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
