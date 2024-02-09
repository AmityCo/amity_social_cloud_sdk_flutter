import 'package:amity_sdk/src/core/model/api_request/get_reach_user_request.dart';
import 'package:amity_sdk/src/core/model/api_request/send_analytics_event_request.dart';
import 'package:amity_sdk/src/data/data.dart';

abstract class AnalyticsApiInterface {

  Future sendAnalyticsEvents(SendAnalyticsEventsRequest request);
  Future<UsersResponse> queryPostReachUsers(GetReachUserRequest request);
  Future<UsersResponse> queryStorySeenUsers(GetReachUserRequest request);
}