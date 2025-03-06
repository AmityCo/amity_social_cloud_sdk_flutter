import 'package:amity_sdk/src/core/mqtt/event/story/story_event_listener.dart';

class StoryReactionRemovedEventListener extends StroyEventListener{
  @override
  String getEventName() {
    return 'story.reactionRemoved';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }

}