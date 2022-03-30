import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
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
    } catch (error) {
      print(error.toString());
      return Future.error(error.toString());
    }
  }
}
