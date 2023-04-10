import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class FollowApiInterfaceImpl extends FollowApiInterface {
  FollowApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<FollowResponse> accpet(String userId) async {
    try {
      final data = await httpApiClient().post(
        '$ME_FOLLLOWERS/$userId',
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
      final data = await httpApiClient().delete(
        '$ME_FOLLLOWERS/$userId',
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
      final data = await httpApiClient().post(
        '$ME_FOLLLOWING/$userId',
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
      final data = await httpApiClient().delete(
        '$ME_FOLLLOWING/$userId',
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
      final data = await httpApiClient().get(
        '$USER_FOLLLOW_INFO$userId/followInfo',
      );
      return FollowInfoResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getFollower(FollowRequest request) async {
    try {
      final data =
          await httpApiClient().get('$USER_FOLLLOWERS/${request.userId}/followers', queryParameters: request.toJson());
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getFollowing(FollowRequest request) async {
    try {
      final data =
          await httpApiClient().get('$USER_FOLLLOWING/${request.userId}/following', queryParameters: request.toJson());
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowInfoResponse> getMyFollowInfo() async {
    try {
      final data = await httpApiClient().get(
        ME_FOLLLOW_INFO,
      );
      return FollowInfoResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getMyFollower(FollowRequest request) async {
    try {
      final data = await httpApiClient().get(ME_FOLLLOWERS, queryParameters: request.toJson());
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<FollowResponse> getMyFollowing(FollowRequest request) async {
    try {
      final data = await httpApiClient().get(ME_FOLLLOWING, queryParameters: request.toJson());
      return FollowResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
