import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_target_hive_entity_28.dart';
import 'package:amity_sdk/src/domain/model/amity_story_target.dart';

extension StoryTargetHiveExtentionConverter on StoryTargetHiveEntity {
  AmityStoryTarget convertToAmityStoryTarget() {
    AmityStoryTargetType storytargetType =
        AmityStoryTargetTypeExtension.enumOf(targetType!);
    switch (storytargetType) {
      case AmityStoryTargetType.COMMUNITY:
        return AmityStoryTargetCommunity(
            targetId: targetId!,
            lastStoryExpiresAt: lastStoryExpiresAt,
            lastStorySeenExpiresAt: lastStorySeenExpiresAt,
            hasUnseen: false,
            localSortingDate: localSortingDate,
            localLastStoryExpiresAt: localLastStoryExpiresAt,
            localLastStorySeenExpiresAt: localLastStorySeenExpiresAt);
      case AmityStoryTargetType.USER:
        return AmityStoryTargetUser(
            targetId: targetId!,
            lastStoryExpiresAt: lastStoryExpiresAt,
            lastStorySeenExpiresAt: lastStorySeenExpiresAt,
            hasUnseen: false,
            localSortingDate: localSortingDate,
            localLastStoryExpiresAt: localLastStoryExpiresAt,
            localLastStorySeenExpiresAt: localLastStorySeenExpiresAt);
      default:
        return AmityStoryTargetUnknown(
            targetId: targetId!,
            lastStoryExpiresAt: lastStoryExpiresAt,
            lastStorySeenExpiresAt: lastStorySeenExpiresAt,
            hasUnseen: false,
            localSortingDate: localSortingDate,
            localLastStoryExpiresAt: localLastStoryExpiresAt,
            localLastStorySeenExpiresAt: localLastStorySeenExpiresAt);
    }
  }
}
