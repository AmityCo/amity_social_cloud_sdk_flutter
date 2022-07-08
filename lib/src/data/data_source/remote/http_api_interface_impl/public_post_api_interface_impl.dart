// ignore_for_file: unused_local_variable

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// Post Public Api Interface Impl
class PublicPostApiInterfaceImpl extends PublicPostApiInterface {
  /// Init Post public api clint
  PublicPostApiInterfaceImpl({required this.httpApiClient});

  /// Http clinet to make API request
  final HttpApiClient httpApiClient;
  @override
  Future<CreatePostResponse> getPostById(String postId) async {
    try {
      final data = await httpApiClient().get('$POST_V3/$postId');
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
      final data = await httpApiClient().delete('$POST_V3/$postId');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> flagPost(String postId) async {
    try {
      final data = await httpApiClient().post('$POST_V3/$postId/flag');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> isPostFlagByMe(String postId) async {
    try {
      final data = await httpApiClient().post('$POST_V3/$postId/isflagbyme');
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
          await httpApiClient().get(POST_V4, queryParameters: request.toJson());
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> unflagPost(String postId) async {
    try {
      final data = await httpApiClient().delete('$POST_V3/$postId/flag');
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
          .put('$POST_V4/${request.postId}', data: request);
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> approvePost(String postId) async {
    try {
      final data = await httpApiClient().post('$POST_V3/$postId/approve');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> declinePost(String postId) async {
    try {
      final data = await httpApiClient().post('$POST_V3/$postId/decline');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
