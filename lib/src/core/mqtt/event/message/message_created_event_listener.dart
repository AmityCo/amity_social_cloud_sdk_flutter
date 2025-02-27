import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/engine/object_resolver_engine.dart';
import 'package:amity_sdk/src/core/enum/events/message_preview_event.dart';
import 'package:amity_sdk/src/core/session/event_bus/message_preview_event_bus.dart';
import 'package:amity_sdk/src/core/mqtt/event/message/message_event_listener.dart';
import 'package:amity_sdk/src/data/response/core_response/sub_channel_response.dart';
import 'package:amity_sdk/src/src.dart';

class MessageCreatedEventListener extends MessageEventListener {
  
  @override
  String getEventName() {
    return 'message.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }

  @override void processEvent(Map<String, dynamic> json) {
    super.processEvent(json);
    final data = CreateMessageResponse.fromJson(json);
    // Update message preview for each channel
    for (var message in data.messages) {
      final subChannel = data.subChannels.cast<SubChannelResponse?>().firstWhere((subChannel) => subChannel?.subChannelId == message.subChannelId, orElse: () => null);
      if (subChannel != null) {
        MessagePreviewEventBus().publish(MessagePreviewEvent.messageCreated(message, subChannel));
      }
    }
    // Resolve channel if missing
    final channelIds = data.messages.map((message) => message.channelId).toSet().toList();
    List<String> unresolvedChannelIds = [];
    final channelRepo = serviceLocator<ChannelRepo>();
    for (var channelId in channelIds) {
      if (!channelRepo.hasInLocal(channelId)) {
        unresolvedChannelIds.add(channelId);
      }
    }
    if (unresolvedChannelIds.isNotEmpty) {
      CoreClient.resolveAll(unresolvedChannelIds, ResolveRefType.CHANNEL);
    }
  }
}
