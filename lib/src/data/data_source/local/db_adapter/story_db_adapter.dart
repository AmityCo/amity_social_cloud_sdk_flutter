import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';

abstract class StoryDbAdapter {

  Future saveStoryEntity(StoryHiveEntity data);
  
  Future deleteStoryEntity(String storyId);
  
  Future deleteAllStoryEntity();

  Future updateSyncState(String storyId , String syncState);

  StoryHiveEntity? getStoryEntity(String storyId);

  Stream<List<StoryHiveEntity>> listenStoryEntities(
      RequestBuilder<GetStoriesByTragetRequest> request);

}