import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/mqtt/event/message/message_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';

class MessageReactionRemovedEventListener extends MessageEventListener {
  
  @override
  String getEventName() {
    return 'message.reactionRemoved';
  }
  
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateMessageResponse.fromJson(json);
    final reactor = data.reactions.firstOrNull;
    reactor?.copyWith(eventName: "remove");
    data.messages.firstOrNull?.latestReaction = reactor?.toJson();
    data.saveToDb(serviceLocator());
  }

}
