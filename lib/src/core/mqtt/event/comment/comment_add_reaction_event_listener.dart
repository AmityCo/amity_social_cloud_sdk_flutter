import 'package:amity_sdk/src/core/mqtt/event/event.dart';

/// [CommentCreateEventListener]
class CommentAddReactionEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.addReaction';
  }
}
