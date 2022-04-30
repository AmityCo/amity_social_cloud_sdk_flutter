import 'package:amity_sdk/src/data/data_source/local/hive_entity/post_data_hive_entity_7.dart';
import 'package:hive/hive.dart';

part 'post_hive_entity_5.g.dart';

@HiveType(typeId: 5)
class PostHiveEntity extends HiveObject {
  String? id;
  String? path;
  String postId = '';
  String? parentPostId;
  String? postedUserId;
  String? sharedUserId;
  int? sharedCount;
  String? targetId;
  String? targetType;
  String? dataType;
  PostChildDataHiveEntity? data;
  //  DataClass metadata;
  int? flagCount;
  //  HashFlag hashFlag;
  DateTime? editedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Map<String, int>? reactions;
  int? reactionsCount;
  List<String>? myReactions;
  int? commentsCount;
  List<String>? comments;
  List<String>? children;
  bool? isDeleted;
  bool? hasFlaggedComment;
  bool? hasFlaggedChildren;
  String? feedId;
  String? require;
}
