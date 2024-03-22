import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/core/model/api_request/story_delete_by_id_request.dart';
import 'package:amity_sdk/src/domain/model/amity_story.dart';

abstract class StoryRepo{
  Future<AmityStory> createStory(CreateStoryRequest request);
  Future<List<AmityStory>> getStories(GetStoriesByTragetRequest request);
  Stream<List<AmityStory>> listenStories(RequestBuilder<GetStoriesByTragetRequest> request);
  bool hasLocalStory(String storyId);
  Future<bool> deleteStoryById(StoryDeleteByIdRequest params);
}