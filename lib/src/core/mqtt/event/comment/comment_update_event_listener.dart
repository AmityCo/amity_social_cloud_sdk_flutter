import 'package:amity_sdk/src/core/core.dart';

/// [CommentUpdateEventListener]
class CommentUpdateEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.updated';
  }
}
