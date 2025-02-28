import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/converter/story/create_story_response_extension.dart';
import 'package:amity_sdk/src/data/response/create_story_response.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:amity_sdk/src/domain/usecase/story/story_has_local_usecase.dart';

abstract class StroyEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final event = getEventName();
    var reactor =
        json["reactor"] == null ? null : Reactor.fromJson(json['reactor']);
    final fromAddReactionEvent = event == 'story.reactionAdded';
    if (fromAddReactionEvent) {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "add").toJson();
      }
    } else if (event == 'story.reactionRemoved') {
      if (reactor != null) {
        json["reactor"] = reactor.copyWith(eventName: "remove").toJson();
      }
    }
    final data = CreateStoryResponse.fromJson(json );
    data.saveEventToDb(serviceLocator(), fromAddReactionEvent: fromAddReactionEvent);
  }

  /// This method is used to check if the event should be processed or not.
  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateStoryResponse.fromJson(json);
    if (data.stories.isNotEmpty) {
      return _hasLocalStory(data.stories[0].storyId!);
    } else {
      return false;
    }
  }

  bool _hasLocalStory(String storyId) {
    return serviceLocator<StoryHasLocalUseCase>().get(storyId);
  }
}