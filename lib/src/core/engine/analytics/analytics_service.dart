import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/engine/analytics/capturer/view_post_event_capturer.dart';

class AnalyticsService{
  void markPostAsViewed(String postId) {
        AmityCoreClient.getAnalyticsEngine()?.getCapturerInstance<ViewPostEventCapturer>()?.captureEvent(postId);
    }
}