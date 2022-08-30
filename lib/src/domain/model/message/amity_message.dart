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

  @override
  String toString() {
    return 'AmityMessage(messageId: $messageId, channelId: $channelId, userId: $userId, parentId: $parentId, channelSegment: $channelSegment, childrenNumber: $childrenNumber, isDeleted: $isDeleted, readByCount: $readByCount, flagCount: $flagCount, amityTags: $amityTags, myReactions: $myReactions, reactions: $reactions, reactionCount: $reactionCount, user: $user, metadata: $metadata, mentionees: $mentionees, createdAt: $createdAt, updatedAt: $updatedAt, editedAt: $editedAt)';
  }
}

/// [AmityMessageData]
abstract class AmityMessageData {
  /// Message Id
  final String messageId;

  /// File id
  final String? fileId;

  /// Raw Data
  final Map<String, dynamic>? rawData;

  /// File info
  late AmityFileInfo fileInfo;

  /// Init Amity Post Data
  AmityMessageData({required this.messageId, this.fileId, this.rawData});

  @override
  String toString() =>
      'AmityMessageData(messageId: $messageId, fileId: $fileId, rawData: $rawData)';
}

/// Text Message Data
class MessageTextData extends AmityMessageData {
  /// Text Data
  String? text;

  /// Init Text Data
  MessageTextData({
    required String messageId,
    this.text,
  }) : super(messageId: messageId);

  @override
  String toString() => 'MessageTextData(text: $text)';
}

/// Image Message Data
class MessageImageData extends AmityMessageData {
  /// Amity Image
  late AmityImage image;

  /// Caption
  String? caption;

  /// Image Message Data
  MessageImageData(
      {required String messageId,
      required String fileId,
      required this.caption})
      : super(messageId: messageId, fileId: fileId);

  @override
  String toString() => 'MessageImageData(fileId: $fileId)';
}

/// [MessageFileData]
class MessageFileData extends AmityMessageData {
  /// Amity File
  late AmityFile file;

  /// Caption
  String? caption;

  /// init [MessageFileData]
  MessageFileData(
      {required String messageId,
      required String fileId,
      required this.caption})
      : super(messageId: messageId, fileId: fileId);

  @override
  String toString() => 'MessageFileData(fileId: $fileId)';
}

/// [MessageAudioData]
class MessageAudioData extends AmityMessageData {
  /// Amity File
  late AmityAudio audio;

  /// init [MessageFileData]
  MessageAudioData({
    required String messageId,
    required String fileId,
  }) : super(messageId: messageId, fileId: fileId);

  @override
  String toString() => 'MessageFileData(fileId: $fileId)';
}

/// [MessageCustomData]
class MessageCustomData extends AmityMessageData {
  /// init [MessageCustomData]
  MessageCustomData(
      {required String messageId, required Map<String, dynamic> rawData})
      : super(messageId: messageId, rawData: rawData);

  @override
  String toString() => 'MessageFileData(fileId: $messageId)';
}
