import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:dio/dio.dart';

class PublicPostApiInterfaceImpl extends PublicPostApiInterface {
  PublicPostApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getPostById(String postId) async {
    try {
      final data = await httpApiClient().get(POST_V3 + '/$postId');
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> createPost(CreatePostRequest request) async {
    try {
      final data = await httpApiClient().post(POST_V4, data: request);
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
