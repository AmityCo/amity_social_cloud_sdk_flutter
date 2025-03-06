import 'package:amity_sdk/src/core/mqtt/event/channel/channel_event_listener.dart';

class ChannelUnbannedEventListener extends ChannelEventListener {

  @override
  String getEventName() {
    return 'channel.unbanned';
  }
}
