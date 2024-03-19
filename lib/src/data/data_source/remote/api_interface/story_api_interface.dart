import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/core/model/api_request/story_delete_by_id_request.dart';
import 'package:amity_sdk/src/data/response/create_story_response.dart';

abstract class StoryApiInterface{
  /// Create Story
  Future<CreateStoryResponse> createStory(CreateStoryRequest request);
  // Get Stroies by Target
  Future<CreateStoryResponse> getStories( GetStoriesByTragetRequest request);
  // Delete Story
  Future<bool> deleteStoryById( StoryDeleteByIdRequest params);
}