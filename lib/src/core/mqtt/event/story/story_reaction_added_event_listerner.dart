import 'package:amity_sdk/src/core/mqtt/event/story/story_event_listener.dart';

class StoryReactionAddedEventListener extends StroyEventListener{
  @override
  String getEventName() {
    return 'story.reactionAdded';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }

}