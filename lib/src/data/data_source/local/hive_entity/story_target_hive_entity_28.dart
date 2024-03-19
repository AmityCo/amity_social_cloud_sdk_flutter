import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

part 'story_target_hive_entity_28.g.dart';

@HiveType(typeId: 28)
class StoryTargetHiveEntity  extends EkoObject {

  String? targetId;

  String? targetType = AmityStoryTargetType.UNKNOWN.value;

  DateTime? lastStoryExpiresAt;

  DateTime? lastStorySeenExpiresAt;

  DateTime? targetUpdatedAt;

  // Local Feild

  bool? hasUnseen = false;

  DateTime? localSortingDate;

  DateTime? localLastStoryExpiresAt;

  DateTime? localLastStorySeenExpiresAt;

  StoryTargetHiveEntity({
    this.targetId,
    this.targetType,
    this.lastStoryExpiresAt,
    this.lastStorySeenExpiresAt,
    this.targetUpdatedAt,
    this.hasUnseen = false,
    this.localSortingDate,
    this.localLastStoryExpiresAt,
    this.localLastStorySeenExpiresAt
  });


  StoryTargetHiveEntity copyWith({
    String? targetId,
    String? targetType,
    DateTime? lastStoryExpiresAt,
    DateTime? lastStorySeenExpiresAt,
    DateTime? targetUpdatedAt,
    bool? hasUnseen,
    DateTime? localSortingDate,
    DateTime? localLastStoryExpiresAt,
    DateTime? localLastStorySeenExpiresAt
  }){
    return StoryTargetHiveEntity(
      targetId: targetId ?? this.targetId,
      targetType: targetType ?? this.targetType,
      lastStoryExpiresAt: lastStoryExpiresAt ?? this.lastStoryExpiresAt,
      lastStorySeenExpiresAt: lastStorySeenExpiresAt ?? this.lastStorySeenExpiresAt,
      targetUpdatedAt: targetUpdatedAt ?? this.targetUpdatedAt,
      hasUnseen: hasUnseen ?? this.hasUnseen,
      localSortingDate: localSortingDate ?? this.localSortingDate,
      localLastStoryExpiresAt: localLastStoryExpiresAt ?? this.localLastStoryExpiresAt,
      localLastStorySeenExpiresAt: localLastStorySeenExpiresAt ?? this.localLastStorySeenExpiresAt
    );

  }


  @override
  String? getId() {
    return targetId;
  }

}
