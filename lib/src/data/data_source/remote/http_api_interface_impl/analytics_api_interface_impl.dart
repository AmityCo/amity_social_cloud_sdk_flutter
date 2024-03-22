import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_reach_user_request.dart';
import 'package:amity_sdk/src/core/model/api_request/send_analytics_event_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/analytics_api_interface.dart';
import 'package:amity_sdk/src/data/response/users_response.dart';
import 'package:dio/dio.dart';

class AnalyticsApiInterfaceImpl extends AnalyticsApiInterface{

  /// Public HTTP client
  final HttpApiClient httpApiClient;

  /// Init [AnalyticsApiInterfaceImpl]  
  AnalyticsApiInterfaceImpl({required this.httpApiClient});



  @override
  Future<UsersResponse> queryPostReachUsers(GetReachUserRequest request) async {
    try {
      final data = await httpApiClient().get(
        "$REACH_POSTS${request.postId!}/users",
        queryParameters: request.toJson(),
      );
      return UsersResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future sendAnalyticsEvents(SendAnalyticsEventsRequest request) async {
    try {
      final data = await httpApiClient().post(
          ANALYTICS,
          data: request.toJson());
      return Future;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
  
  @override
  Future<UsersResponse> queryStorySeenUsers(GetReachUserRequest request) async {
    try {
      final data = await httpApiClient().get(
        "$REACH_STORIES${request.storyId!}/users",
        queryParameters: request.toJson(),
      );
      return UsersResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
  
}