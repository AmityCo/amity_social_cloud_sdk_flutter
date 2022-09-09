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

  @override
  String toString() {
    return 'MessageHiveEntity(messageId: $messageId, channelId: $channelId, userId: $userId, type: $type, data: $data, channelSegment: $channelSegment, parentId: $parentId, fileId: $fileId, tags: $tags, metadata: $metadata, flagCount: $flagCount, childrenNumber: $childrenNumber, reactionsCount: $reactionsCount, reactions: $reactions, myReactions: $myReactions, latestReaction: $latestReaction, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, editedAt: $editedAt, syncState: $syncState)';
  }
}
