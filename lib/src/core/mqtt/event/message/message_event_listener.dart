import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_update_last_activity_usecase.dart';

///[MessageEventListener]
class MessageEventListener extends MQTTEventListener {
  @override
  String getEventName() {
    return '';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    final event = getEventName();
    var reactor =
        json["reactor"] == null ? null : Reactor.fromJson(json['reactor']);
    final fromAddReactionEvent = event == 'message.reactionAdded';
    if (fromAddReactionEvent) {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "add").toJson();
      }
    } else if (event == 'message.reactionRemoved') {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "remove").toJson();
      }
    }

    final data = CreateMessageResponse.fromJson(json);

    data.saveEventToDb(serviceLocator(), fromAddReactionEvent: fromAddReactionEvent);

    final channelId = data.messages[0].channelId;
    serviceLocator<ChannelUpdateLastActivityUsecase>().process(channelId);
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateMessageResponse.fromJson(json);
    final uniqueId = data.messages[0].referenceId ?? data.messages[0].messageId;
    if (data.messages.isNotEmpty) {
      return _hasLocalMessage(uniqueId);
    } else {
      return false;
    }
  }

  bool _hasLocalMessage(String messageId) {
    return serviceLocator<MessageHasLocalUsecase>().get(messageId);
  }
}
