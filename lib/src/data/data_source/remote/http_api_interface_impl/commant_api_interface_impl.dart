// ignore_for_file: unused_local_variable

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/create_comment_response.dart';
import 'package:dio/dio.dart';

class CommentApiInterfaceImpl extends CommentApiInterface {
  final HttpApiClient httpApiClient;

  CommentApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<CreateCommentResponse> createComment(
      CreateCommentRequest request) async {
    try {
      final data = await httpApiClient().post(COMMENT_V3, data: request);
      return CreateCommentResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    try {
      final data = await httpApiClient().delete(COMMENT_V3 + '/$commentId');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateCommentResponse> queryComment(GetCommentRequest request) async {
    try {
      // final data =
      //     await httpApiClient().get(COMMENT_V3, data: request.toJson());
      final data = await httpApiClient()
          .get(COMMENT_V3, queryParameters: request.toJson());
      return CreateCommentResponse.fromJson(data.data);
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
  Future<CreateCommentResponse> getComment(String commentId) async {
    try {
      final data = await httpApiClient().get(COMMENT_V3 + '/$commentId');
      return CreateCommentResponse.fromJson(data.data);
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
  Future<CreateCommentResponse> updateComment(
      String commentId, UpdateCommentRequest request) async {
    try {
      final data =
          await httpApiClient().put(COMMENT_V3 + '/$commentId', data: request);
      return CreateCommentResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
