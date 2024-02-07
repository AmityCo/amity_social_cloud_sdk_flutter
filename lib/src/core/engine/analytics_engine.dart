import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/engine/analytics/analytics_event_syncer.dart';
import 'package:amity_sdk/src/core/engine/analytics/capturer/analytics_event_capturer.dart';
import 'package:amity_sdk/src/core/engine/analytics/capturer/view_post_event_capturer.dart';
import 'package:amity_sdk/src/core/session/component/session_component.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_state_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/session_state.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';

class AnalyticsEngine extends SessionComponent {
  AnalyticsEventSyncer eventSyncer = AnalyticsEventSyncer(
      analyticsRepository: serviceLocator<AnalyticsRepo>());

  AnalyticsEngine({
    required SessionLifeCycleEventBus sessionLifeCycleEventBus,
    required SessionStateEventBus sessionStateEventBus,
  }) : super(
          sessionLifeCycleEventBus: sessionLifeCycleEventBus,
          sessionStateEventBus: sessionStateEventBus,
        );

  List<AnalyticsEventCapturer> eventCapturers = [
    ViewPostEventCapturer(),
  ];

  Type? getCapturerInstance<Type>() {
    if (sessionState == SessionState.Established || sessionState == SessionState.TokenExpired) {
      return eventCapturers.whereType<Type>().first;
    }
    return null;
    
  }

  @override
  void destroy() {
    eventSyncer.stop();
    // eventSyncer.deleteAllAnalyticsEvents();
  }

  @override
  void establish() {
    eventSyncer.start();
  }

  @override
  void handleTokenExpire() {
    eventSyncer.stop();
  }

  @override
  void onSessionStateChange(SessionState sessionState) {
    // TODO: implement onSessionStateChange
  }
}
