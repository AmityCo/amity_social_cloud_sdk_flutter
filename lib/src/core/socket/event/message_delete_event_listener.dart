import 'package:amity_sdk/src/core/socket/event/message_event_listener.dart';

class MessageDeleteventListener extends MessageEventListener {
  @override
  String getEventName() {
    return 'v3.message.didDelete';
  }
}
