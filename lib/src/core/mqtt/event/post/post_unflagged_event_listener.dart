import 'package:amity_sdk/src/core/core.dart';

/// [PostFlaggedEventListener]
class PostUnflaggedEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.unflagged';
  }
}
