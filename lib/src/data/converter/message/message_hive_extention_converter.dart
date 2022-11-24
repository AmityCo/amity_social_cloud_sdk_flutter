import 'package:amity_sdk/src/core/enum/amity_message_type.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageHiveExtensionConverter]
extension MessageHiveExtensionConverter on MessageHiveEntity {
  ///
  AmityMessage convertToAmityMessage() {
    //Data type
    AmityMessageDataType amityMessageDataType =
        AmityMessageDataTypeExtension.enumOf(type!);

    AmityMessageData? amityMessageData;
    switch (amityMessageDataType) {
      case AmityMessageDataType.TEXT:
        amityMessageData =
            MessageTextData(messageId: messageId!, text: data!.text);
        break;
      case AmityMessageDataType.IMAGE:
        amityMessageData = MessageImageData(
          messageId: messageId!,
          fileId: fileId!,
          caption: data!.caption,
        );
        break;
      case AmityMessageDataType.AUDIO:
        amityMessageData = MessageAudioData(
          messageId: messageId!,
          fileId: fileId!,
        );
        break;
      case AmityMessageDataType.FILE:
        amityMessageData = MessageFileData(
          messageId: messageId!,
          fileId: fileId!,
          caption: data!.caption,
        );
        break;
      case AmityMessageDataType.CUSTOM:
        amityMessageData = MessageCustomData(
          messageId: messageId!,
          rawData: data!.toMap(),
        );
        break;
    }

    return AmityMessage()
      ..messageId = messageId
      ..channelId = channelId
      ..userId = userId
      ..type = amityMessageDataType
      ..data = amityMessageData
      ..syncState = syncState
      ..channelSegment = channelSegment
      ..parentId = parentId
      // ..fileId = fileId
      ..amityTags = AmityTags(tags: tags ?? [])
      ..metadata = metadata
      ..flagCount = flagCount
      ..childrenNumber = childrenNumber
      ..reactionCount = reactionsCount
      ..reactions = AmityReactionMap(reactions: reactions)
      ..myReactions = myReactions
      // ..latestReaction = latestReaction
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..editedAt = editedAt;
  }
}
