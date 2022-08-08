import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/post_data_hive_entity_7.dart';
import 'package:hive/hive.dart';

part 'comment_hive_entity_6.g.dart';

/// Comment Hive Entity
@HiveType(typeId: 6)
class CommentHiveEntity extends HiveObject {
  /// Comment doc id
  String? id;

  /// Comment doc path
  String? path;

  /// Comment id
  String commentId = '';

  /// Comment User Id
  String? userId;

  /// Parent Comment Id
  String? parentId;

  /// root Id
  String? rootId;

  /// reference Id
  String? referenceId;

  /// reference type
  String? referenceType;

  /// Comment data type
  String? dataType;

  ///
  PostChildDataHiveEntity? data;

  /// metadata
  Map<String, dynamic>? metadata;

  /// child comment number
  int? childrenNumber;

  /// flag count
  int? flagCount;

  /// has flag
  Map<String, dynamic>? hashFlag;
  // HashFlag? hashFlag;
  // ReactionResponse? reactions;

  /// Comment Reaction
  Map<String, int>? reactions;

  /// Comment Reaction Count
  int? reactionsCount;

  /// My Reaction
  List<String>? myReactions;

  /// flag is Comment Delete
  bool? isDeleted;

  /// Comment Edit time
  DateTime? editedAt;

  /// Comment Create At
  DateTime? createdAt;

  /// Comment Update At
  DateTime? updatedAt;

  /// child Comment Ids
  List<String>? children;

  /// Segment Number
  int? segmentNumber;

  ///
  String? required;

  ///
  bool? flaggedByMe;
}
