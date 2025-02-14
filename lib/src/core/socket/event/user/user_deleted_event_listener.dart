import 'package:amity_sdk/src/core/socket/event/user/user_event_listener.dart';

class UserDeletedEventListener extends UserEventListener {
  @override
  String getEventName() {
    return "user.deleted";
  }
}
