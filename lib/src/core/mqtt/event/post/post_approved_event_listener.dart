import 'package:amity_sdk/src/core/core.dart';

class PostApprovedEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.approved';
  }
}
