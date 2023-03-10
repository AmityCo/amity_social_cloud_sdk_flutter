import 'package:amity_sdk/src/core/socket/event/event.dart';

/// [CommentCreateEventListener]
class CommentRemoveReactionEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.removeReaction';
  }
}
