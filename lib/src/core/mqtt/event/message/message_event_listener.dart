import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/mqtt/event/mqtt_event_listener.dart';
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
    final data = CreateMessageResponse.fromJson(json);

    /// Exclude the update if we dont have my rection key
    if (data.messages[0].myReactions == null) {
      final amityMessage = serviceLocator<MessageGetLocalUsecase>()
          .get(data.messages[0].referenceId ?? data.messages[0].messageId);
      data.messages[0].myReactions = amityMessage?.myReactions;
    }
    final dbRepo = serviceLocator<DbAdapterRepo>();
    data.saveToDb(dbRepo);

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
