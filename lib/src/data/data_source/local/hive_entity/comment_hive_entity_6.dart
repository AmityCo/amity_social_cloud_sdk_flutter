import 'package:amity_sdk/src/data/data.dart';
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
  String commentId;

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

  /// Comment data types
  List<String>? dataTypes;

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

  /// Mentions
  List<Mentionee>? mentionees;

  ///Attachment
  List<AttachmentResponse>? attachments;

  CommentHiveEntity({
    this.id,
    this.path,
    this.commentId = '',
    this.userId,
    this.parentId,
    this.rootId,
    this.referenceId,
    this.referenceType,
    this.dataType,
    this.data,
    this.metadata,
    this.childrenNumber,
    this.flagCount,
    this.hashFlag,
    this.reactions,
    this.reactionsCount,
    this.myReactions,
    this.isDeleted,
    this.editedAt,
    this.createdAt,
    this.updatedAt,
    this.children,
    this.segmentNumber,
    this.required,
    this.flaggedByMe,
    this.mentionees,
    this.attachments,
  });

  CommentHiveEntity copyWith({
    String? id,
    String? path,
    String? commentId,
    String? userId,
    String? parentId,
    String? rootId,
    String? referenceId,
    String? referenceType,
    String? dataType,
    PostChildDataHiveEntity? data,
    Map<String, dynamic>? metadata,
    int? childrenNumber,
    int? flagCount,
    Map<String, dynamic>? hashFlag,
    Map<String, int>? reactions,
    int? reactionsCount,
    List<String>? myReactions,
    bool? isDeleted,
    DateTime? editedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? children,
    int? segmentNumber,
    String? required,
    bool? flaggedByMe,
    List<Mentionee>? mentionees,
    List<AttachmentResponse>? attachments,
  }) {
    return CommentHiveEntity(
      id: id ?? this.id,
      path: path ?? this.path,
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      parentId: parentId ?? this.parentId,
      rootId: rootId ?? this.rootId,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      dataType: dataType ?? this.dataType,
      data: data ?? this.data,
      metadata: metadata ?? this.metadata,
      childrenNumber: childrenNumber ?? this.childrenNumber,
      flagCount: flagCount ?? this.flagCount,
      hashFlag: hashFlag ?? this.hashFlag,
      reactions: reactions ?? {...?this.reactions},
      reactionsCount: reactionsCount ?? this.reactionsCount,
      myReactions: myReactions ?? [...?this.myReactions],
      isDeleted: isDeleted ?? this.isDeleted,
      editedAt: editedAt ?? this.editedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      children: children ?? this.children,
      segmentNumber: segmentNumber ?? this.segmentNumber,
      required: required ?? this.required,
      flaggedByMe: flaggedByMe ?? this.flaggedByMe,
      mentionees: mentionees ?? this.mentionees,
      attachments: attachments ?? this.attachments,
    );
  }
}
