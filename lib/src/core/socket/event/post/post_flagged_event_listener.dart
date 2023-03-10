import 'package:amity_sdk/src/core/core.dart';

/// [PostFlaggedEventListener]
class PostFlaggedEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.flagged';
  }
}
