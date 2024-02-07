import 'package:amity_sdk/src/core/core.dart';

class PostDeclinedEventListener extends PostEventListener {
  @override
  String getEventName() {
    return 'post.declined';
  }
}
