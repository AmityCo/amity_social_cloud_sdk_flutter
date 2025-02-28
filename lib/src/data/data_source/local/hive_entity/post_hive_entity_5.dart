import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/interface/reaction_related_entity.dart';
import 'package:hive/hive.dart';

part 'post_hive_entity_5.g.dart';

/// Post Hive entity
@HiveType(typeId: 5)
class PostHiveEntity extends EkoObject implements ReactionRelatedEntity<PostHiveEntity> {
  /// doc Id
  @HiveField(0)
  String? id;

  /// doc path
  @HiveField(1)
  String? path;

  /// post ID
  @HiveField(2)
  String? postId;

  /// in case of child post, Id of parent post
  @HiveField(3)
  String? parentPostId;

  /// posted user id
  @HiveField(4)
  String? postedUserId;

  /// shared with user id
  @HiveField(5)
  String? sharedUserId;

  /// share cound for the post
  @HiveField(6)
  int? sharedCount;

  /// target ID
  @HiveField(7)
  String? targetId;

  /// target Type
  @HiveField(8)
  String? targetType;

  /// data type for the post
  @HiveField(9)
  String? dataType;

  /// data for the post
  @HiveField(10)
  PostChildDataHiveEntity? data;

  /// metadata
  @HiveField(11)
  Map<String, dynamic>? metadata;

  /// flag count
  @HiveField(12)
  int? flagCount;

  /// has flag
  @HiveField(13)
  Map<String, dynamic>? hashFlag;

  /// edit at
  @HiveField(14)
  DateTime? editedAt;

  /// created at
  @HiveField(15)
  DateTime? createdAt;

  /// updated at
  @HiveField(16)
  DateTime? updatedAt;

  /// reactions map
  @override
  @HiveField(17)
  Map<String, int>? reactions;

  /// reaction count
  @override
  @HiveField(18)
  int? reactionsCount;

  /// my reaction list
  @override
  @HiveField(19)
  List<String>? myReactions;

  /// comment count for the post
  @HiveField(20)
  int? commentsCount;

  /// comments
  @HiveField(21)
  List<String>? comments;

  /// child post
  @HiveField(22)
  List<String>? children;

  /// local flag for deleting the flag
  @HiveField(23)
  bool? isDeleted;

  /// check if post have flagged comment
  @HiveField(24)
  bool? hasFlaggedComment;

  /// check if post have flagged child post
  @HiveField(25)
  bool? hasFlaggedChildren;

  /// feed ID
  @HiveField(26)
  String? feedId;

  /// feed Type
  @HiveField(27)
  String? feedType;

  ///
  @HiveField(28)
  String? require;

  ///
  @HiveField(29)
  bool? flaggedByMe;

  ///
  @HiveField(30)
  int? impression;

  ///
  @HiveField(31)
  int? reach;

  /// Mentions
  @HiveField(32)
  List<MentioneeHiveEntity>? mentionees;

  /// Json raw data for custom post
  @HiveField(33)
  Map<String, dynamic>? rawData;

  PostHiveEntity({
    this.id,
    this.path,
    this.postId,
    this.parentPostId,
    this.postedUserId,
    this.sharedUserId,
    this.sharedCount,
    this.targetId,
    this.targetType,
    this.dataType,
    this.data,
    this.metadata,
    this.flagCount,
    this.hashFlag,
    this.editedAt,
    this.createdAt,
    this.updatedAt,
    this.reactions,
    this.reactionsCount,
    this.myReactions,
    this.commentsCount,
    this.comments,
    this.children,
    this.isDeleted,
    this.hasFlaggedComment,
    this.hasFlaggedChildren,
    this.feedId,
    this.feedType,
    this.require,
    this.flaggedByMe,
    this.mentionees,
    this.impression,
    this.reach,
    this.rawData,
  });

  PostHiveEntity copyWith({
    String? id,
    String? path,
    String? postId,
    String? parentPostId,
    String? postedUserId,
    String? sharedUserId,
    int? sharedCount,
    String? targetId,
    String? targetType,
    String? dataType,
    Map<String, dynamic>? rawData,
    PostChildDataHiveEntity? data,
    Map<String, dynamic>? metadata,
    int? flagCount,
    Map<String, dynamic>? hashFlag,
    DateTime? editedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? reactions,
    int? reactionsCount,
    List<String>? myReactions,
    int? commentsCount,
    List<String>? comments,
    List<String>? children,
    bool? isDeleted,
    bool? hasFlaggedComment,
    bool? hasFlaggedChildren,
    String? feedId,
    String? feedType,
    String? require,
    bool? flaggedByMe,
    int? impression,
    int? reach,
    List<MentioneeHiveEntity>? mentionees,
  }) {
    return PostHiveEntity(
      id: id ?? this.id,
      path: path ?? this.path,
      postId: postId ?? this.postId,
      rawData: rawData ?? this.rawData,
      parentPostId: parentPostId ?? this.parentPostId,
      postedUserId: postedUserId ?? this.postedUserId,
      sharedUserId: sharedUserId ?? this.sharedUserId,
      sharedCount: sharedCount ?? this.sharedCount,
      targetId: targetId ?? this.targetId,
      targetType: targetType ?? this.targetType,
      dataType: dataType ?? this.dataType,
      data: data ?? this.data,
      metadata: metadata ?? this.metadata,
      flagCount: flagCount ?? this.flagCount,
      hashFlag: hashFlag ?? this.hashFlag,
      editedAt: editedAt ?? this.editedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reactions: reactions ?? {...?this.reactions},
      reactionsCount: reactionsCount ?? this.reactionsCount,
      myReactions: myReactions ?? [...?this.myReactions],
      commentsCount: commentsCount ?? this.commentsCount,
      comments: comments ?? this.comments,
      children: children ?? this.children,
      isDeleted: isDeleted ?? this.isDeleted,
      hasFlaggedComment: hasFlaggedComment ?? this.hasFlaggedComment,
      hasFlaggedChildren: hasFlaggedChildren ?? this.hasFlaggedChildren,
      feedId: feedId ?? this.feedId,
      feedType: feedType ?? this.feedType,
      require: require ?? this.require,
      flaggedByMe: flaggedByMe ?? this.flaggedByMe,
      mentionees: mentionees ?? this.mentionees,
      impression: impression ?? this.impression,
      reach: reach ?? this.reach,
    );
  }

  @override
  PostHiveEntity copyEntity() {
    return copyWith();
  }
  
  @override
  String? getId() {
    return id;
  }
}
