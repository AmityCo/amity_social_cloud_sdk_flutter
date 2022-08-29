import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_has_local_usecase.dart';

class MessageEventListener extends SocketEventListener {
  @override
  String getEventName() {
    return '';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateMessageResponse.fromJson(json);
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
