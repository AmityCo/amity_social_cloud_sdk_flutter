import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/reaction_related_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';

abstract class StoryDbAdapter with ReactionRelatedDBAdapter<StoryHiveEntity> {
  Future saveStoryEntity(StoryHiveEntity data);

  Future deleteStoryEntity(String storyId);

  Future deleteAllStoryEntity();

  Future updateSyncState(String storyId, String syncState);

  StoryHiveEntity? getStoryEntity(String storyId);

  Stream<StoryHiveEntity> listenPostEntity(String storyId);

  List<StoryHiveEntity> getStoriesBySyncStates(String targetType, String targetId, List<AmityStorySyncState> states);

  Stream<List<StoryHiveEntity>> listenStoryEntities(
      RequestBuilder<GetStoriesByTragetRequest> request);

  DateTime? getHighestStoryExpiresAt(String targetType, String targetId, List<AmityStorySyncState> states);

  int getStoryCount(String targetType, String targetId,  List<AmityStorySyncState> states);
}
