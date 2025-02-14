import 'package:amity_sdk/src/core/enum/amity_message_preview_setting.dart';
import 'package:amity_sdk/src/data/response/core_response/sub_channel_response.dart';
import 'package:amity_sdk/src/src.dart';

enum MessagePreviewEventName {
  messageCreated,
  messageUpdated,
  messageDeleted,
  subChannelUpdated,
  subChannelDeleted,
  messagePreviewSettingChange,
  unknown,
}
class MessagePreviewEvent {
  final MessagePreviewEventName eventName;
  final MessageResponse? message;
  final SubChannelResponse? subChannel;
  final AmityMessagePreviewSetting? messagePreviewSetting;

  MessagePreviewEvent.messageCreated(
    MessageResponse this.message,
    SubChannelResponse this.subChannel,
  ) : eventName = MessagePreviewEventName.messageCreated, messagePreviewSetting = null;

  MessagePreviewEvent.messageUpdated(
    MessageResponse this.message,
    SubChannelResponse this.subChannel,
  ) : eventName = MessagePreviewEventName.messageUpdated, messagePreviewSetting = null;

  MessagePreviewEvent.messageDeleted(
    MessageResponse this.message,
    SubChannelResponse this.subChannel,
  ) : eventName = MessagePreviewEventName.messageDeleted, messagePreviewSetting = null;

  MessagePreviewEvent.subChannelUpdated(
    SubChannelResponse this.subChannel,
  ) : eventName = MessagePreviewEventName.subChannelUpdated, message = null, messagePreviewSetting = null;

  MessagePreviewEvent.subChannelDeleted(
    SubChannelResponse this.subChannel,
  ) : eventName = MessagePreviewEventName.subChannelDeleted, message = null, messagePreviewSetting = null;

  MessagePreviewEvent.messagePreviewSettingChange(
    AmityMessagePreviewSetting this.messagePreviewSetting,
  ) : eventName = MessagePreviewEventName.messagePreviewSettingChange, message = null, subChannel = null;
}

extension MessagePreviewEventExtension on MessagePreviewEvent {
  bool isEvent(MessagePreviewEventName eventName) {
    return this.eventName == eventName;
  }

  bool isMessageEvent() {
    return switch (eventName) {
      MessagePreviewEventName.messageCreated => true,
      MessagePreviewEventName.messageUpdated => true,
      MessagePreviewEventName.messageDeleted => true,
      _ => false,
    };
  }
  
  bool isSubChannelEvent() {
    return switch (eventName) {
      MessagePreviewEventName.subChannelUpdated => true,
      MessagePreviewEventName.subChannelDeleted => true,
      _ => false,
    };
  }
}