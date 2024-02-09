import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/engine/analytics/analytics_event_sync_priority.dart';
import 'package:amity_sdk/src/data/repo_impl/analytics_repo_impl.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';

class AnalyticsEventCapturer {
  String contentType;
  String eventType;
  AnalyticsEventSyncPriority syncPriority;

  AnalyticsEventCapturer(
      {required this.contentType,
      required this.eventType,
      required this.syncPriority});

  Map<String, DateTime?> recentCaptured = <String, DateTime?>{};

  void captureEvent(
    String contentId,
  ) {
    var recentCapturedEvents = recentCaptured[contentId];
    if (recentCapturedEvents == null) {
      recentCaptured[contentId] = DateTime.now();
    } else {
      if (recentCaptured[contentId]!
          .add(Duration(seconds: 5))
          .isAfter(DateTime.now())) {
        return;
      }
    }
    serviceLocator<AnalyticsRepo>()
        .saveAnalyticsEvent(contentId, contentType, eventType, syncPriority)
        .then((value) => recentCaptured[contentId] = DateTime.now());
  }
}
