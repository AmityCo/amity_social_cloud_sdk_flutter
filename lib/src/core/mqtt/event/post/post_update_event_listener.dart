import 'package:amity_sdk/src/core/core.dart';

/// [PostUpdateEventListener]
class PostUpdateEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.updated';
  }
}
