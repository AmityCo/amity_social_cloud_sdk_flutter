
import 'package:amity_sdk/src/core/session/event_bus/base_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/session_state.dart';

class SessionStateEventBus extends BaseEventBus<SessionState>{
  static final SessionStateEventBus _instance = SessionStateEventBus._internal();

  factory SessionStateEventBus() => _instance;

  SessionStateEventBus._internal();

  

}