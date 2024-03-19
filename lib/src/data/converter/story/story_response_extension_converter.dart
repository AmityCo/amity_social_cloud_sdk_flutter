import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';
import 'package:amity_sdk/src/data/response/response.dart';

extension StroyResponseExtensionConverter on StoryResponse {
  StoryHiveEntity convertToStoryHiveEntity() {
    return StoryHiveEntity(
      storyId: storyId!,
      dataType: dataType,
      data: data,
      items: items,
      flagCount: flagCount,
      reactionsCount: reactionsCount,
      myReactions: myReactions,
      commentsCount: commentsCount,
      isDeleted: isDeleted,
      hasFlaggedComment: hasFlaggedComment,
      mentionedUsers: mentionedUsers,
      impression: impression,
      reach: reach,
      referenceId: referenceId,
      creatorId: creatorId,
      creatorPublicId: creatorPublicId,
      targetType: targetType,
      targetId: targetId,
      targetPublicId: targetPublicId,
      metadata: metadata,
      hashFlag: hashFlag,
      createdAt: createdAt,
      updatedAt: updatedAt,
      expiresAt: expiresAt,
      reactions: reactions,
    );
  }


}
