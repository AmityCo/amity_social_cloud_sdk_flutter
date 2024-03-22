import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/converter/file_response_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/story/story_hive_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/story/story_response_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/story_target/story_target_reposnse_conveter_extension.dart';
import 'package:amity_sdk/src/data/converter/user_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_target_hive_entity_28.dart';
import 'package:amity_sdk/src/data/response/create_story_response.dart';

extension CreateStoryResponseExtension on CreateStoryResponse {
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    List<StoryHiveEntity> storyHiveEntities =
        stories.map((e) => e.convertToStoryHiveEntity()).toList();
    
    List<StoryTargetHiveEntity> storyTargetHiveEntities =
        storyTargets.map((e) => e.convertToStoryTargetHiveEntity()).toList();

    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    for (var e in storyHiveEntities) {
      e.syncState = AmityStorySyncState.SYNCED.value;
      await dbRepo.storyDbAdapter.saveStoryEntity(e);
    }

    for (var e in storyTargetHiveEntities) {
      await dbRepo.storyTargetDbAdapter.saveStoryTargetEntity(e);
    }

    if (T.toString() == 'AmityStory') {
      return storyHiveEntities
          .map((e) =>  e.convertToAmityStory())
          .toList();
    }
  }
}