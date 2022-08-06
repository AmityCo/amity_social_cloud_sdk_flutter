import 'package:amity_sdk/src/data/data_source/local/hive_entity/post_data_hive_entity_7.dart';
import 'package:hive/hive.dart';

part 'post_hive_entity_5.g.dart';

/// Post Hive entity
@HiveType(typeId: 5)
class PostHiveEntity extends HiveObject {
  /// doc Id
  String? id;

  /// doc path
  String? path;

  /// post ID
  String postId = '';

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

  ///
  String? require;
}
