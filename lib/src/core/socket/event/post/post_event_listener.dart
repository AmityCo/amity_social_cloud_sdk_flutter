import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

///[PostEventListener]
abstract class PostEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final event = getEventName();
    var reactor =
        json["reactor"] == null ? null : Reactor.fromJson(json['reactor']);
    final fromAddReactionEvent = event == 'post.addReaction';
    if (fromAddReactionEvent) {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "add").toJson();
      }
    } else if (event == 'post.removeReaction') {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "remove").toJson();
      }
    }
    final data = CreatePostResponse.fromJson(json);
    data.saveEventToDb(serviceLocator(), fromAddReactionEvent: fromAddReactionEvent);
  }

  /// This method is used to check if the event should be processed or not.
  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreatePostResponse.fromJson(json);
    if (data.posts.isNotEmpty) {
      return _hasLocalPost(data.posts[0].postId);
    } else {
      return false;
    }
  }

  bool _hasLocalPost(String postId) {
    return serviceLocator<PostHasLocalUsecase>().get(postId);
  }
}
