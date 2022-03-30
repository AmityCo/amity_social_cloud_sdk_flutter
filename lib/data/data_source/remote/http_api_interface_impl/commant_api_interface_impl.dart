import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
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

  @override
  Future<bool> flagComment(String commentId) async {
    try {
      final data =
          await httpApiClient().post(COMMENT_V3 + '/$commentId' + '/flag');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> getComment(String commentId) async {
    try {
      final data = await httpApiClient().get(COMMENT_V3 + '/$commentId');
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> isCommentFlagByMe(String commentId) async {
    try {
      final data =
          await httpApiClient().get(COMMENT_V3 + '/$commentId' + '/isflagbyme');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> unflagComment(String commentId) async {
    try {
      final data =
          await httpApiClient().delete(COMMENT_V3 + '/$commentId' + '/unflag');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> updateComment(
      String commentId, CreateCommentRequest request) async {
    try {
      final data =
          await httpApiClient().put(COMMENT_V3 + '/$commentId', data: request);
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
