import 'package:amity_sdk/src/core/enum/amity_message_sync_state.dart';
import 'package:amity_sdk/src/core/enum/amity_message_type.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityMessage]
class AmityMessage {
  /// Message ID
  String? messageId;

  /// Channel ID
  String? channelId;

  /// User ID
  String? userId;

  /// Parent ID
  String? parentId;

  /// Channel Segment
  int? channelSegment;

  /// Children Number
  int? childrenNumber;

  /// Is Deleted
  bool? isDeleted = false;

  /// read by Count
  int? readByCount;

  /// Flag Count
  int? flagCount;

  /// Amity Tags
  AmityTags? amityTags;

  /// My Reactions
  List<String>? myReactions = [];

  /// Reactions
  AmityReactionMap? reactions;

  /// ReactionCount
  int? reactionCount;

  /// User
  AmityUser? user;

  /// Message Data Type
  AmityMessageDataType? type;

  /// Message Data
  AmityMessageData? data;

  /// Sync State
  AmityMessageSyncState? syncState;

  /// Meta data
  Map<String, dynamic>? metadata;

  /// Mentionees
  List<AmityMentionee>? mentionees; //com

  /// Created At
  DateTime? createdAt;

  /// Updated At
  DateTime? updatedAt;

  /// Edited At
  DateTime? editedAt;
}

/// [AmityMessageData]
abstract class AmityMessageData {
  /// Message Id
  final String messageId;

  /// File id
  final String? fileId;

  /// Raw Data
  final Map<String, dynamic>? rawData;

  /// Init Amity Post Data
  AmityMessageData({required this.messageId, this.fileId, this.rawData});
}

/// Text Post Data
class MessageTextData extends AmityMessageData {
  /// Text Data
  String? text;

  /// Init Text Data
  MessageTextData({
    required String messageId,
    this.text,
  }) : super(messageId: messageId);

  @override
  String toString() =>
      'MessageTextData(MessageTextData: $MessageTextData, text: $text)';
}
