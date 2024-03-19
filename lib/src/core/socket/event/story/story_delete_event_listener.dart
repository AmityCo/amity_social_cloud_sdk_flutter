import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/story/story_event_listener.dart';
import 'package:amity_sdk/src/data/converter/story/create_story_response_extension.dart';
import 'package:amity_sdk/src/data/converter/story/story_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_db_adapter.dart';
import 'package:amity_sdk/src/data/response/create_story_response.dart';

class StoryDeleteEventListener extends StroyEventListener{
  @override
  String getEventName() {
    return 'story.deleted';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateStoryResponse.fromJson(json);
    // data.saveToDb(serviceLocator());
    for (var element in data.stories) {
      serviceLocator<StoryDbAdapter>().deleteStoryEntity(element.storyId!);
    }
  }

}