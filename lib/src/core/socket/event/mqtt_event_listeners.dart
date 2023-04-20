import 'package:amity_sdk/src/core/socket/event/event.dart';
import 'package:collection/collection.dart' show IterableExtension;

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

    ///Community Event
    CommunityCreateEventListener(),
    CommunityUpdateEventListener(),
    CommunityDeleteEventListener(),

    /// Community Member Event
    CommunityJoinEventListener(),
    CommunityLeftEventListener(),
    CommunityUserAddedEventListener(),
    CommunityUserRemovedEventListener(),
    CommunityRoleAddedEventListener(),
    CommunityRoleRemovedEventListener(),
    CommunityUserChangedEventListener(),
    CommunityUserBannedEventListener(),
    CommunityUserUnbannedEventListener(),
  ]);

  SocketEventListener? getEvent(String eventType) =>
      listeners.firstWhereOrNull((element) => element.getEventName() == eventType);
}
