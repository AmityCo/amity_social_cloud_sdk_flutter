import 'package:amity_sdk/src/core/mqtt/event/message/message_event_listener.dart';

class MessageUnflaggedEventListener extends MessageEventListener {
  @override
  String getEventName() {
    return 'message.unflagged';
  }
}
