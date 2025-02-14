import 'package:amity_sdk/src/core/enum/events/message_preview_event.dart';
import 'package:amity_sdk/src/core/session/event_bus/message_preview_event_bus.dart';
import 'package:amity_sdk/src/core/socket/event/message/message_event_listener.dart';
import 'package:amity_sdk/src/data/response/core_response/sub_channel_response.dart';
import 'package:amity_sdk/src/data/response/response.dart';

class MessageUpdatedEventListener extends MessageEventListener {
  @override
  String getEventName() {
    return 'message.updated';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    super.processEvent(json);
    final data = CreateMessageResponse.fromJson(json);
    for (var message in data.messages) {
      final subChannel = data.subChannels.cast<SubChannelResponse?>().firstWhere((subChannel) => subChannel?.subChannelId == message.subChannelId, orElse: () => null);
      if (subChannel != null) {
        MessagePreviewEventBus().publish(MessagePreviewEvent.messageUpdated(message, subChannel));
      }
    }
  }
}
