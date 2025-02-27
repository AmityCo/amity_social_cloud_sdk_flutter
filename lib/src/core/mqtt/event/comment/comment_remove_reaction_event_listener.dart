import 'package:amity_sdk/src/core/mqtt/event/event.dart';

/// [CommentCreateEventListener]
class CommentRemoveReactionEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.removeReaction';
  }
}
