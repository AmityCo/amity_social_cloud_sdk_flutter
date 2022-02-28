import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/commnet_api_interface.dart';
import 'package:dio/dio.dart';

class CommentApiInterfaceImpl extends CommentApiInterface {
  final HttpApiClient httpApiClient;

  CommentApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<CreatePostResponse> createComment(CreateCommentRequest request) async {
    try {
      final data = await httpApiClient().post(COMMENT_V3, data: request);
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    try {
      final data = await httpApiClient().get(COMMENT_V3 + '/$commentId');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> queryComment(GetCommentRequest request) async {
    try {
      // final data =
      //     await httpApiClient().get(COMMENT_V3, data: request.toJson());
      final data = await httpApiClient()
          .get(COMMENT_V3, queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
