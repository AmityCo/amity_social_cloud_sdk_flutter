import 'package:amity_sdk/src/core/mqtt/event/user/user_event_listener.dart';

class UserFlagClearedEventListener extends UserEventListener {
  @override
  String getEventName() {
    return "user.flagCleared";
  }
}
