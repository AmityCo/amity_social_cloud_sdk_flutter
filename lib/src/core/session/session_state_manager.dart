import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_state_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/core/session/model/session_state.dart';
import 'package:amity_sdk/src/core/session/transformer/session_life_cycle_transformer.dart';
import 'package:amity_sdk/src/core/session/transformer/session_state_transformer.dart';

class SessionStateManager {
  final SessionLifeCycleEventBus sessionLifeCycleEventBus;
  final SessionStateEventBus sessionStateEventBus;
  final AppEventBus appEventBus;

  SessionState sessionState = SessionState.NotLoggedIn;

  SessionStateManager(
      {required this.sessionLifeCycleEventBus,
      required this.sessionStateEventBus,
      required this.appEventBus}) {
    observeAppEvent();
    observeSessionState();
  }

  void observeAppEvent() {
    appEventBus.observe().listen((event) {
      SessionState? newSessionState = SessionStateTransformer().transform(sessionState, event);
      if (newSessionState != null) {
        sessionStateEventBus.publish(newSessionState);
      }
    });
  }

  void observeSessionState() {
    sessionStateEventBus.observe().listen((event) {
      sessionState = event;
      SessionLifeCycle? sessionLifeCycle =
          SessionLifeCycleTransformer().transform(event);
      if (sessionLifeCycle != null) {
        sessionLifeCycleEventBus.publish(sessionLifeCycle);
      }
    });
  }
}
