import 'package:amity_sdk/src/core/engine/analytics/analytics_event_sync_priority.dart';
import 'package:amity_sdk/src/core/engine/analytics/capturer/analytics_event_capturer.dart';

class ViewPostEventCapturer extends AnalyticsEventCapturer {
  ViewPostEventCapturer()
      : super(
            contentType: "post",
            eventType: "view",
            syncPriority: AnalyticsEventSyncPriority.LOW);
}
