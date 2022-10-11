import 'package:amity_sdk/src/core/enum/amity_message_sync_state.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_data_hive_entity_19.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'message_hive_entity_18.g.dart';

/// Post Hive entity
@HiveType(typeId: 18)
class MessageHiveEntity extends HiveObject {
  /// Message ID
  String? messageId;

  /// Channel ID
  String? channelId;

  /// User ID
  String? userId;

  /// Type
  String? type;

  /// Message Data
  MessageDataHiveEntity? data;

  /// Channel Segment
  int? channelSegment;

  /// Parent ID
  String? parentId;

  /// File ID
  String? fileId;

  /// Tags
  List<String>? tags;

  /// Metadata
  Map<String, dynamic>? metadata;

  /// Flag Count
  int? flagCount;

  /// Hash Flag
  // _HashFlag hashFlag;

  /// Childer number
  int? childrenNumber;

  /// Reactions count
  int? reactionsCount;

  /// Reactions
  Map<String, int>? reactions;

  /// My Reaction
  List<String>? myReactions;

  /// Latest Reaction
  Map<String, dynamic>? latestReaction;

  /// Is Deleted
  bool? isDeleted;

  /// Created At
  DateTime? createdAt;

  /// Updated At
  DateTime? updatedAt;

  /// Edited At
  DateTime? editedAt;

  /// Mentions
  // List<Mentionee> mentionees;

  /// Sync State
  AmityMessageSyncState? syncState;

  MessageHiveEntity({
    this.messageId,
    this.channelId,
    this.userId,
    this.type,
    this.data,
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
    this.syncState,
  });

  @override
  String toString() {
    return 'MessageHiveEntity(messageId: $messageId, channelId: $channelId, userId: $userId, type: $type, data: $data, channelSegment: $channelSegment, parentId: $parentId, fileId: $fileId, tags: $tags, metadata: $metadata, flagCount: $flagCount, childrenNumber: $childrenNumber, reactionsCount: $reactionsCount, reactions: $reactions, myReactions: $myReactions, latestReaction: $latestReaction, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, editedAt: $editedAt, syncState: $syncState)';
  }

  MessageHiveEntity copyWith({
    String? messageId,
    String? channelId,
    String? userId,
    String? type,
    MessageDataHiveEntity? data,
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
    AmityMessageSyncState? syncState,
  }) {
    return MessageHiveEntity(
      messageId: messageId ?? this.messageId,
      channelId: channelId ?? this.channelId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      data: data ?? this.data,
      channelSegment: channelSegment ?? this.channelSegment,
      parentId: parentId ?? this.parentId,
      fileId: fileId ?? this.fileId,
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
      syncState: syncState ?? this.syncState,
    );
  }
}
