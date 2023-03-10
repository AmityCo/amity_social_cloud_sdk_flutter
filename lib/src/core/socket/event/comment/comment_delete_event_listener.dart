import 'package:amity_sdk/src/core/core.dart';

/// [CommentDeleteEventListener]
class CommentDeleteEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.deleted';
  }
}
