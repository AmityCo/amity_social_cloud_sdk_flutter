import 'package:amity_sdk/src/core/core.dart';

/// [PostDeleteEventListener]
class PostDeleteEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.deleted';
  }
}
