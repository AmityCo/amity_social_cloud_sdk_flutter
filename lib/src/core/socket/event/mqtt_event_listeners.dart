import 'package:amity_sdk/src/core/socket/event/event.dart';
import 'package:collection/collection.dart';

class MqttEventListeners {
  final listeners = List.of([
    ///Post Event
    PostCreateEventListener(),
    PostUpdateEventListener(),
    PostDeleteEventListener(),
    PostAddReactionEventListener(),
    PostRemoveReactionEventListener(),
    PostFlaggedEventListener(),
    PostUnflaggedEventListener(),

    ///Comment Event
    CommentCreateEventListener(),
    CommentUpdateEventListener(),
    CommentDeleteEventListener(),
    CommentAddReactionEventListener(),
    CommentRemoveReactionEventListener(),
    CommentFlaggedEventListener(),
    CommentUnflaggedEventListener(),
  ]);

  SocketEventListener? getEvent(String eventType) => listeners
      .firstWhereOrNull((element) => element.getEventName() == eventType);
}
