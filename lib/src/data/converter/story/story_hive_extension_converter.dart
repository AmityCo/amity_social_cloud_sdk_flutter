import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';

extension StoryHiveExtentionConverter on StoryHiveEntity {
  AmityStory convertToAmityStory() {
    AmityStoryDataType amityStoryDataType = AmityStoryDataTypeExtension.enumOf(dataType ?? "UNKNOWN");
    var storyTarget = AmityStoryTargetTypeExtension.enumOf(targetType ?? "UNKNOWN");

    AmityStorySyncState syncState = AmityStorySyncStateExtension.enumOf(this.syncState ?? "SYNCED");

    return AmityStory()
      ..storyId = storyId
      ..dataType = amityStoryDataType
      ..storyItems = items ?? []
      ..rawData = data?.toJson()
      ..flagCount = flagCount ?? 0
      ..reactionCount = reactionsCount ?? 0
      ..myReactions = myReactions ?? []
      ..commentCount = commentsCount ?? 0
      ..isDeleted = isDeleted ?? false
      ..impression = impression ?? 0
      ..creatorId = creatorId
      ..creatorPublicId = creatorPublicId
      ..targetType = storyTarget
      ..targetId = targetId
      ..targetPublicId = targetPublicId
      ..metadata = metadata ?? {}
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..expiresAt = expiresAt
      ..syncState = syncState
      ..reactions = reactions ?? {}
      ..reach = reach?? 0;
  }


  bool isMatchingFilter(GetStoriesByTragetRequest request){
    if(request.targets == null){
      return isMatchingTargetType(request.targetType!) && isMatchingTargetid(request.targetId!);
    }else{
      return isSyned() && request.targets!.containsKey(targetType!) && request.targets![targetType!] == targetId;
    }
  }

  bool isMatchingTargetType(String targetType) {
    return this.targetType == targetType;
  }

  bool isMatchingTargetid(String targetId) {
    return this.targetId == targetId;
  }

  bool isMatchingTargets(AmityStoryDataType dataType) {
    return this.dataType == dataType.value;
  }

  bool isSyned() {
    return syncState == AmityStorySyncState.SYNCED.value;
  }
}
