import 'package:amity_sdk/src/core/mqtt/event/channel/channel_event_listener.dart';

class ChannelJoinedEventListener extends ChannelEventListener {

  @override
  String getEventName() {
    return 'channel.joined';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}
