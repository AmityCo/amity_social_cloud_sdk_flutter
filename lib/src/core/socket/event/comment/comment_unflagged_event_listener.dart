import 'package:amity_sdk/src/core/core.dart';

/// [CommentFlaggedEventListener]
class CommentUnflaggedEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.unflagged';
  }
}
