import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_state_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/core/session/model/session_state.dart';

abstract class SessionComponent {
  SessionLifeCycleEventBus sessionLifeCycleEventBus;
  SessionStateEventBus sessionStateEventBus;

  SessionComponent({
    required this.sessionLifeCycleEventBus,
    required this.sessionStateEventBus,
  }) {
    initSessionState();
    observeSessionLifeCycle();
    observeSessionState();
  }

  SessionState sessionState = SessionState.NotLoggedIn;

  void onSessionStateChange(SessionState sessionState);
  void establish();
  void destroy();
  void handleTokenExpire();

  SessionStateEventBus getSessionStateEventBus() {
    return sessionStateEventBus;
  }

  SessionLifeCycleEventBus getSessionLifeCycleEventBus() {
    return sessionLifeCycleEventBus;
  }

  void initSessionState() {
    var currEvent = sessionStateEventBus.getCurrentEvent();
    if (currEvent != null) {
      sessionState = currEvent!;
    }
  }

  void observeSessionLifeCycle() {
    sessionLifeCycleEventBus.observe().listen((event) {
      switch (event) {
        case SessionLifeCycle.Establish:
          establish();
          break;
        case SessionLifeCycle.Destroy:
          destroy();
          break;
        case SessionLifeCycle.HandleTokenExpire:
          handleTokenExpire();
          break;
        case SessionLifeCycle.StateChange:
          sessionState = sessionStateEventBus.getCurrentEvent()!;
          onSessionStateChange(sessionState);
          break;
      }
    });
  }

  void observeSessionState() {
    sessionStateEventBus.observe().listen((event) {
      sessionState = event;
      onSessionStateChange(sessionState);
    });
  }
}
