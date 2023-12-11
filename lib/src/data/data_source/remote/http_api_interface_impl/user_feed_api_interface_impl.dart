import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class UserFeedApiInterfaceImpl extends UserFeedApiInterface {
  UserFeedApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getUserFeed(GetUserFeedRequest request) async {
    try {
      final data = await httpApiClient().get(
          '$USER_FEED_V3_URL/${request.userId}',
          queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
