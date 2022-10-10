import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_has_local_usecase.dart';

///[MessageEventListener]
class MessageEventListener extends SocketEventListener {
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
          .get(data.messages[0].messageId);
      data.messages[0].myReactions = amityMessage?.myReactions;
    }

    data.saveToDb(serviceLocator());
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateMessageResponse.fromJson(json);
    if (data.messages.isNotEmpty) {
      return _hasLocalMessage(data.messages[0].messageId);
    } else {
      return false;
    }
  }

  bool _hasLocalMessage(String messageId) {
    return serviceLocator<MessageHasLocalUsecase>().get(messageId);
  }
}
