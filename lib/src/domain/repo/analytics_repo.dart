import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/engine/analytics/analytics_event_sync_priority.dart';
import 'package:amity_sdk/src/core/model/api_request/get_reach_user_request.dart';

abstract class AnalyticsRepo {
  Future saveAnalyticsEvent(String contentId, String contentType,
      String activityType, AnalyticsEventSyncPriority syncPriority);
  void deleteAllAnalyticsEvents();
  Future sendAnalyticsEvents(AnalyticsEventSyncPriority syncPriority);
  Future<PageListData<List<AmityUser>, String>> getViewedUsers(GetReachUserRequest request);
}
