import 'package:amity_sdk/src/core/core.dart';

/// [PostCreateEventListener]
class PostCreateEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}
