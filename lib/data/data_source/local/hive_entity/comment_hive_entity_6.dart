import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/post_data_hive_entity_7.dart';
import 'package:hive/hive.dart';

part 'comment_hive_entity_6.g.dart';

@HiveType(typeId: 6)
class CommentHiveEntity {
  String? id;
  String? path;
  String commentId = '';
  String? userId;
  String? parentId;
  String? rootId;
  String? referenceId;
  String? referenceType;
  String? dataType;
  PostChildDataHiveEntity? data;
  //  DataClass metadata;
  int? childrenNumber;
  int? flagCount;
  // HashFlag? hashFlag;
  // ReactionResponse? reactions;
  int? reactionsCount;
  List<String>? myReactions;
  bool? isDeleted;
  DateTime? editedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? children;
  int? segmentNumber;
  String? required;
}
