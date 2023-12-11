import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// Global Feed API Impl
class GlobalFeedApiInterfaceImpl extends GlobalFeedApiInterface {
  /// Init Global Feed API
  GlobalFeedApiInterfaceImpl({required this.httpApiClient});

  /// Http Api Client
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getGlobalFeed(GetGlobalFeedRequest request) async {
    try {
      final data = await httpApiClient()
          .get(GLOBAL_FEED_V3_URL, queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    } catch (error) {
      rethrow;
    }
  }
}
