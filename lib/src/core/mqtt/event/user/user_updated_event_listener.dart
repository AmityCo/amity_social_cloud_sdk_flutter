import 'package:amity_sdk/src/core/mqtt/event/user/user_event_listener.dart';

class UserUpdatedEventListener extends UserEventListener {
  @override
  String getEventName() {
    return "user.updated";
  }
}
