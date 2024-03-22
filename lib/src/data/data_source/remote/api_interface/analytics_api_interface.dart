
import 'package:amity_sdk/src/src.dart';

abstract class AnalyticsApiInterface {
  Future sendAnalyticsEvents(SendAnalyticsEventsRequest request);
  Future<UsersResponse> queryPostReachUsers(GetReachUserRequest request);
  Future<UsersResponse> queryStorySeenUsers(GetReachUserRequest request);
}