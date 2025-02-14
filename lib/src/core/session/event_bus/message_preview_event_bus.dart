
import 'package:amity_sdk/src/core/enum/events/message_preview_event.dart';
import 'package:amity_sdk/src/core/session/event_bus/base_event_bus.dart';

class MessagePreviewEventBus extends BaseEventBus<MessagePreviewEvent> {
  static final MessagePreviewEventBus _instance = MessagePreviewEventBus._internal();

  factory MessagePreviewEventBus() => _instance;

  MessagePreviewEventBus._internal();
}