import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_target_hive_entity_28.dart';

abstract class StoryTargetDbAdapter {

  Future saveStoryTargetEntity(StoryTargetHiveEntity data);
  
  Future deleteStoryTargetEntity(String targetId);
  
  Future deleteAllStoryTargetEntity();

  StoryTargetHiveEntity? getStoryTargetEntity(String targetId);
      
}