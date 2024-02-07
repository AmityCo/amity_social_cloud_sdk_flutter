import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/core/session/model/session_state.dart';

class SessionStateTransformer {
  static final SessionStateTransformer _instance =
      SessionStateTransformer._internal();

  factory SessionStateTransformer() {
    return _instance;
  }

  SessionStateTransformer._internal();

  SessionState? transform(SessionState currentSessionState, AppEvent appEvent) {
    switch (appEvent) {
      case AppEvent.AppLaunchWithUser:
        if (currentSessionState == SessionState.NotLoggedIn) {
          return SessionState.Established;
        }
        break;
      case AppEvent.AppLaunchWithoutUser:
        return SessionState.NotLoggedIn;
      case AppEvent.LoggingIn:
        if (currentSessionState == SessionState.NotLoggedIn ||
            currentSessionState == SessionState.Established ||
            currentSessionState == SessionState.Terminated) {
          return SessionState.Establishing;
        }
        break;
      case AppEvent.LoginSuccess:
        if (currentSessionState == SessionState.Establishing) {
          return SessionState.Established;
        }
        break;

      case AppEvent.LoginFail:
        if (currentSessionState == SessionState.Establishing) {
          return SessionState.NotLoggedIn;
        }
        break;
      case AppEvent.ManualLogout:
        return SessionState.NotLoggedIn;

      case AppEvent.TokenRenewSuccess:
        if (currentSessionState == SessionState.TokenExpired) {
          return SessionState.Established;
        }
        break;

      case AppEvent.TerminationCodeReceive:
        if (currentSessionState == SessionState.Established ||
            currentSessionState == SessionState.TokenExpired) {
          return SessionState.Terminated;
        }
        break;
      case AppEvent.TokenExpire:
        return SessionState.TokenExpired;

      default:
        return null;
    }

    return null;
  }
}
