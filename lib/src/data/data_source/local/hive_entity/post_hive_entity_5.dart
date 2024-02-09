import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

part 'post_hive_entity_5.g.dart';

/// Post Hive entity
@HiveType(typeId: 5)
class PostHiveEntity extends EkoObject {
  /// doc Id
  String? id;

  /// doc path
  String? path;

  /// post ID
  String postId;

  /// in case of child post, Id of parent post
  String? parentPostId;

  /// posted user id
  String? postedUserId;

  /// shared with user id
  String? sharedUserId;

  /// share cound for the post
  int? sharedCount;

  /// target ID
  String? targetId;

  /// target Type
  String? targetType;

  /// data type for the post
  String? dataType;

  /// data for the post
  PostChildDataHiveEntity? data;

  /// metadata
  Map<String, dynamic>? metadata;

  /// flag count
  int? flagCount;

  /// has flag
  Map<String, dynamic>? hashFlag;

  /// edit at
  DateTime? editedAt;

  /// created at
  DateTime? createdAt;

  /// updated at
  DateTime? updatedAt;

  /// reactions map
  Map<String, int>? reactions;

  /// reaction count
  int? reactionsCount;

  /// my reaction list
  List<String>? myReactions;

  /// comment count for the post
  int? commentsCount;

  /// comments
  List<String>? comments;

  /// child post
  List<String>? children;

  /// local flag for deleting the flag
  bool? isDeleted;

  /// check if post have flagged comment
  bool? hasFlaggedComment;

  /// check if post have flagged child post
  bool? hasFlaggedChildren;

  /// feed ID
  String? feedId;

  /// feed Type
  String? feedType;

  ///
  String? require;

  ///
  bool? flaggedByMe;

  ///
  int? impression;

  ///
  int? reach;

  /// Mentions
  List<Mentionee>? mentionees;

  PostHiveEntity(
      {this.id,
      this.path,
      this.postId = '',
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
    List<Mentionee>? mentionees,
  }) {
    return PostHiveEntity(
      id: id ?? this.id,
      path: path ?? this.path,
      postId: postId ?? this.postId,
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
  String? getId() {
    return id;
  }
}
