import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/converter/file_response_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/story/story_hive_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/story/story_response_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/story_target/story_target_reposnse_conveter_extension.dart';
import 'package:amity_sdk/src/data/converter/user_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/response/create_story_response.dart';

enum StoryMqttEvent { addReaction, removeReaction }

extension CreateStoryResponseExtension on CreateStoryResponse {
  Future saveToDb<T>(DbAdapterRepo dbRepo, {bool fromAddReactionEvent = false}) async {
    List<FileHiveEntity> fileHiveEntities = files.map((e) => e.convertToFileHiveEntity()).toList();

    List<UserHiveEntity> userHiveEntities = users.map((e) => e.convertToUserHiveEntity()).toList();

    List<StoryHiveEntity> storyHiveEntities = stories.map((e) => e.convertToStoryHiveEntity()).toList();

    List<StoryTargetHiveEntity> storyTargetHiveEntities = storyTargets.map((e) => e.convertToStoryTargetHiveEntity()).toList();

    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    for (var e in storyHiveEntities) {
      e.syncState = AmityStorySyncState.SYNCED.value;
      if (fromAddReactionEvent && e.myReactions == null) {
          final entity = dbRepo.storyDbAdapter.getStoryEntity(e.storyId!);
          e.myReactions = entity?.myReactions;
      }
      await dbRepo.storyDbAdapter.saveStoryEntity(e);
    }

    for (var e in storyTargetHiveEntities) {
      await dbRepo.storyTargetDbAdapter.saveStoryTargetEntity(e);
    }
    

    if (T.toString() == 'AmityStory') {
      return storyHiveEntities.map((e) => e.convertToAmityStory()).toList();
    }
  }

  Future saveEventToDb<T>(DbAdapterRepo dbRepo, {bool fromAddReactionEvent = false}) async {
    await saveToDb<T>(dbRepo, fromAddReactionEvent: fromAddReactionEvent);
    await saveReactionFromEvent(dbRepo, users, reactions.first, AmityReactionReferenceType.STORY);
  }
}
