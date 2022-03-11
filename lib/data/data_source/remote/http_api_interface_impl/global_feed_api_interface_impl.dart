import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/global_feed_api_interface.dart';
import 'package:dio/dio.dart';

class GlobalFeedApiInterfaceImpl extends GlobalFeedApiInterface {
  GlobalFeedApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getGlobalFeed(GetGlobalFeedRequest request) async {
    try {
      final data = await httpApiClient()
          .get(GLOBAL_FEED_V3_URL, queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
