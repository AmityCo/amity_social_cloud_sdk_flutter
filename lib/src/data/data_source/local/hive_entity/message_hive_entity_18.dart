import 'package:amity_sdk/src/core/enum/amity_message_sync_state.dart';
import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/interface/reaction_related_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'message_hive_entity_18.g.dart';

@HiveType(typeId: AmityHiveType.message)
class MessageHiveEntity extends EkoObject implements ReactionRelatedEntity<MessageHiveEntity> {
  @HiveField(0)
  String? uniqueId;

  @HiveField(1)
  String? messageId;

  @HiveField(2)
  String? channelId;

  @HiveField(3)
  String? subChannelId;

  @HiveField(4)
  String? userId;

  @HiveField(5)
  String? type;

  @HiveField(6)
  MessageDataHiveEntity? data;

  @HiveField(7)
  int? channelSegment;

  @HiveField(8)
  String? parentId;

  @HiveField(9)
  String? fileId;

  @HiveField(10)
  List<String>? tags;

  @HiveField(11)
  Map<String, dynamic>? metadata;

  @HiveField(12)
  int? flagCount;

  @HiveField(13)
  Map<String, dynamic>? hashFlag;

  @HiveField(14)
  int? childrenNumber;

  /// Reactions count
  @override
  @HiveField(15)
  int? reactionsCount;

  /// Reactions
  @override
  @HiveField(16)
  Map<String, int>? reactions;

  /// My Reaction
  @override
  @HiveField(17)
  List<String>? myReactions;

  @HiveField(18)
  Map<String, dynamic>? latestReaction;

  @HiveField(19)
  bool? isDeleted;

  @HiveField(20)
  DateTime? createdAt;

  @HiveField(21)
  DateTime? updatedAt;

  @HiveField(22)
  DateTime? editedAt;

  @HiveField(23)
  List<Mentionee>? mentionees;

  @HiveField(24)
  String? syncState;

  @HiveField(25)
  bool? flaggedByMe;

  MessageHiveEntity({
    this.uniqueId,
    this.messageId,
    this.channelId,
    this.userId,
    this.type,
    this.data,
    this.subChannelId,
    this.channelSegment,
    this.parentId,
    this.fileId,
    this.tags,
    this.metadata,
    this.flagCount,
    this.childrenNumber,
    this.reactionsCount,
    this.reactions,
    this.myReactions,
    this.latestReaction,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.editedAt,
    this.mentionees,
    this.syncState,
    this.flaggedByMe,
  });

  @override
  String toString() {
    return 'MessageHiveEntity(uniqueId: $uniqueId, messageId: $messageId, channelId: $channelId, userId: $userId, type: $type, data: $data, channelSegment: $channelSegment, parentId: $parentId, fileId: $fileId, tags: $tags, metadata: $metadata, flagCount: $flagCount, childrenNumber: $childrenNumber, reactionsCount: $reactionsCount, reactions: $reactions, myReactions: $myReactions, latestReaction: $latestReaction, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, editedAt: $editedAt, syncState: $syncState)';
  }

  MessageHiveEntity copyWith({
    String? uniqueId,
    String? messageId,
    String? channelId,
    String? userId,
    String? type,
    MessageDataHiveEntity? data,
    String? subChannelId,
    int? channelSegment,
    String? parentId,
    String? fileId,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    int? flagCount,
    int? childrenNumber,
    int? reactionsCount,
    Map<String, int>? reactions,
    List<String>? myReactions,
    Map<String, dynamic>? latestReaction,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? editedAt,
    List<Mentionee>? mentionees,
    String? syncState,
  }) {
    return MessageHiveEntity(
      uniqueId: uniqueId ?? this.uniqueId,
      messageId: messageId ?? this.messageId,
      channelId: channelId ?? this.channelId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      data: data ?? this.data,
      channelSegment: channelSegment ?? this.channelSegment,
      parentId: parentId ?? this.parentId,
      fileId: fileId ?? this.fileId,
      subChannelId: subChannelId ?? this.subChannelId,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      flagCount: flagCount ?? this.flagCount,
      childrenNumber: childrenNumber ?? this.childrenNumber,
      reactionsCount: reactionsCount ?? this.reactionsCount,
      reactions: reactions ?? {...?this.reactions},
      myReactions: myReactions ?? [...?this.myReactions],
      latestReaction: latestReaction ?? {...?this.latestReaction},
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      editedAt: editedAt ?? this.editedAt,
      mentionees: mentionees ?? this.mentionees,
      syncState: syncState ?? this.syncState,
    );
  }

  @override
  String? getId() {
    return uniqueId;
  }

  @override
  MessageHiveEntity copyEntity() {
    return copyWith();
  }
}
