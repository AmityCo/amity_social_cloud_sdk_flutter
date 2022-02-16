import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:dio/dio.dart';

class FollowApiInterfaceImpl extends FollowWApiInterface {
  FollowApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<FollowResponse> accpet(String userId) async {
    try {
      final data = await httpApiClient.dio.post(
        ME_FOLLLOWERS + '/$userId',
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> decline(String userId) async {
    try {
      final data = await httpApiClient.dio.delete(
        ME_FOLLLOWERS + '/$userId',
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> follow(String userId) async {
    try {
      final data = await httpApiClient.dio.post(
        ME_FOLLLOWING + '/$userId',
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> unfollow(String userId) async {
    try {
      final data = await httpApiClient.dio.delete(
        ME_FOLLLOWING + '/$userId',
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowInfoResponse> getFollowInfo(String userId) async {
    try {
      final data = await httpApiClient.dio.get(
        USERS_v4_URL + '$userId/followInfo',
      );
      return FollowInfoResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getFollower(String userId) async {
    try {
      final data = await httpApiClient.dio.delete(
        USER_V4_URL + '/$userId/followers',
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getFollowing(String userId) async {
    try {
      final data = await httpApiClient.dio.delete(
        USER_V4_URL + '/$userId/following',
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowInfoResponse> getMyFollowInfo() async {
    try {
      final data = await httpApiClient.dio.get(
        ME_FOLLLOW_INFO,
      );
      return FollowInfoResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getMyFollower() async {
    try {
      final data = await httpApiClient.dio.delete(
        ME_FOLLLOWERS,
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getMyFollowing() async {
    try {
      final data = await httpApiClient.dio.delete(
        ME_FOLLLOWING,
      );
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
