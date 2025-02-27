import 'package:amity_sdk/src/core/core.dart';

/// [CommentFlaggedEventListener]
class CommentFlaggedEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.flagged';
  }
}
