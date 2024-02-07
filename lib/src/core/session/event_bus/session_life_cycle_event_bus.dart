
import 'package:amity_sdk/src/core/session/event_bus/base_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';

class SessionLifeCycleEventBus extends BaseEventBus<SessionLifeCycle> {
  static final SessionLifeCycleEventBus _instance = SessionLifeCycleEventBus._internal();

  factory SessionLifeCycleEventBus() => _instance;

  SessionLifeCycleEventBus._internal();
}