

import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/core/session/model/session_state.dart';

class SessionLifeCycleTransformer {
  static final SessionLifeCycleTransformer _instance = SessionLifeCycleTransformer._internal();

  factory SessionLifeCycleTransformer() {
    return _instance;
  }
  
  SessionLifeCycleTransformer._internal();
  
  SessionLifeCycle? transform(SessionState currentSessionState) {
     switch (currentSessionState) {
      case SessionState.TokenExpired:
        return SessionLifeCycle.HandleTokenExpire;
      case SessionState.Terminated:
        return SessionLifeCycle.Destroy;
      case SessionState.NotLoggedIn:
        return SessionLifeCycle.Destroy;
      default:
        return null;
    }
  }
}