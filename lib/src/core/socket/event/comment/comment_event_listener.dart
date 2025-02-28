import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

///[CommentEventListener]
abstract class CommentEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final event = getEventName();
    var reactor =
        json["reactor"] == null ? null : Reactor.fromJson(json['reactor']);
    final fromAddReactionEvent = event == 'comment.addReaction';
    if (fromAddReactionEvent) {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "add").toJson();
      }
    } else if (event == 'comment.removeReaction') {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "remove").toJson();
      }
    }
    final data = CreateCommentResponse.fromJson(json);
    data.saveEventToDb(serviceLocator(), fromAddReactionEvent: fromAddReactionEvent);
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateCommentResponse.fromJson(json);
    if (data.comments.isNotEmpty) {
      return _hasLocalComment(data.comments[0].commentId);
    } else {
      return false;
    }
  }

  bool _hasLocalComment(String messageId) {
    return serviceLocator<CommentHasLocalUseCase>().get(messageId);
  }
}
