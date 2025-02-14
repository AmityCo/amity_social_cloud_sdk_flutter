import 'package:amity_sdk/src/core/enum/events/message_preview_event.dart';
import 'package:amity_sdk/src/core/session/event_bus/message_preview_event_bus.dart';
import 'package:amity_sdk/src/core/socket/event/subchannel/subchannel_event_listener.dart';
import 'package:amity_sdk/src/data/response/response.dart';

class SubChannelUpdateEventListener extends SubChannelEventListener  {
  @override
  String getEventName() {
    return 'message-feed.updated';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    super.processEvent(json);
    final data = CreateSubChannelResponse.fromJson(json);
    data.subChannels.forEach((subChannel) {
      MessagePreviewEventBus().publish(MessagePreviewEvent.subChannelUpdated(subChannel));
    });
  }
  
}