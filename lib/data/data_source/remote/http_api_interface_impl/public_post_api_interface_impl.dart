// ignore_for_file: unused_local_variable

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/update_post_request.dart';
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

  @override
  Future<bool> deletePostById(String postId) async {
    try {
      final data = await httpApiClient().delete(POST_V3 + '/$postId');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> flagPost(String postId) async {
    try {
      final data = await httpApiClient().post(POST_V3 + '/$postId' + '/flag');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> isPostFlagByMe(String postId) async {
    try {
      final data =
          await httpApiClient().post(POST_V3 + '/$postId' + '/isflagbyme');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> queryPost(GetPostRequest request) async {
    try {
      final data =
          await httpApiClient().get(POST_V3, queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> unflagPost(String postId) async {
    try {
      final data = await httpApiClient().delete(POST_V3 + '/$postId' + '/flag');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> updatePostById(UpdatePostRequest request) async {
    try {
      final data = await httpApiClient()
          .put(POST_V3 + '/${request.postId}', data: request);
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
