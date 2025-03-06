import 'package:amity_sdk/src/core/mqtt/event/subchannel/subchannel_event_listener.dart';

class SubChannelCreateEventListener extends SubChannelEventListener  {
  @override
  String getEventName() {
    return 'message-feed.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
  
}