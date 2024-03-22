import 'package:amity_sdk/src/core/enum/amity_story_state.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/core_response/story_data_response.dart';
import 'package:amity_sdk/src/domain/model/amity_story_item.dart';
import 'package:hive/hive.dart';

part 'story_hive_entity_27.g.dart';

@HiveType(typeId: 27)
class StoryHiveEntity extends HiveObject {
  String? storyId;
  String? path;
  String? creatorId;
  String? creatorPublicId;

  String? targetType;
  String? targetId;
  String? targetPublicId;
  String? dataType;
  List<AmityStoryItem>? items;
  StoryDataResponse? data;
  Map<String, dynamic>? metadata;
  int? flagCount;
  HashFlag? hashFlag;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? expiresAt;
  Map<String, int>? reactions;
  int? reactionsCount;
  List<String>? myReactions;
  int? commentsCount;
  bool? isDeleted;
  bool? hasFlaggedComment;
  List<Mentionee>? mentionedUsers;
  int? impression;
  int? reach;
  String? referenceId;
  String syncState = AmityStorySyncState.SYNCED.value;
  bool hasLocalPreview = false;

  StoryHiveEntity({
    this.storyId,
    this.path,
    this.creatorId,
    this.creatorPublicId,
    this.targetType,
    this.targetId,
    this.targetPublicId,
    this.dataType,
    this.items,
    this.data,
    this.metadata,
    this.flagCount,
    this.hashFlag,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.reactions,
    this.reactionsCount,
    this.myReactions,
    this.commentsCount,
    this.isDeleted,
    this.hasFlaggedComment,
    this.mentionedUsers,
    this.impression,
    this.reach,
    this.referenceId,
  });

  StoryHiveEntity copyWith({
    String? storyId,
    String? path,
    String? creatorId,
    String? creatorPublicId,
    String? targetType,
    String? targetId,
    String? targetPublicId,
    String? dataType,
    List<AmityStoryItem>? items,
    StoryDataResponse? data,
    Map<String, dynamic>? metadata,
    int? flagCount,
    HashFlag? hashFlag,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expiresAt,
    Map<String, int>? reactions,
    int? reactionsCount,
    List<String>? myReactions,
    int? commentsCount,
    bool? isDeleted,
    bool? hasFlaggedComment,
    List<Mentionee>? mentionedUsers,
    int? impression,
    int? reach,
    String? referenceId,
  }) {
    return StoryHiveEntity(
      storyId: storyId ?? this.storyId,
      path: path ?? this.path,
      creatorId: creatorId ?? this.creatorId,
      creatorPublicId: creatorPublicId ?? this.creatorPublicId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      targetPublicId: targetPublicId ?? this.targetPublicId,
      dataType: dataType ?? this.dataType,
      items: items ?? this.items,
      data: data ?? this.data,
      metadata: metadata ?? this.metadata,
      flagCount: flagCount ?? this.flagCount,
      hashFlag: hashFlag ?? this.hashFlag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      reactions: reactions ?? this.reactions,
      reactionsCount: reactionsCount ?? this.reactionsCount,
      myReactions: myReactions ?? this.myReactions,
      commentsCount: commentsCount ?? this.commentsCount,
      isDeleted: isDeleted ?? this.isDeleted,
      hasFlaggedComment: hasFlaggedComment ?? this.hasFlaggedComment,
      mentionedUsers: mentionedUsers ?? this.mentionedUsers,
      impression: impression ?? this.impression,
      reach: reach ?? this.reach,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
