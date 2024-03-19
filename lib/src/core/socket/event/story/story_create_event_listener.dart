import 'package:amity_sdk/src/core/socket/event/story/story_event_listener.dart';

class StoryCreateEventListener extends StroyEventListener{
  @override
  String getEventName() {
    return 'story.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }

}