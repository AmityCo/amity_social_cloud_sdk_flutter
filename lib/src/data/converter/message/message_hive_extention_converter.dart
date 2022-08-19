import 'package:amity_sdk/src/core/enum/amity_message_type.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';

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
        // amityPostData = ImageData(postId: postId, fileId: data!.fileId);
        break;
      case AmityMessageDataType.AUDIO:
        // amityPostData = VideoData(
        //   postId: postId,
        //   fileId: data!.thumbnailFileId,
        //   rawData: data?.videoFileId,
        // );
        break;
      case AmityMessageDataType.FILE:
        // amityPostData = FileData(postId: postId, fileId: data!.fileId);
        break;
      case AmityMessageDataType.CUSTOM:
        // TODO: Handle this case.
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
      // ..tags = tags
      ..metadata = metadata
      ..flagCount = flagCount
      ..childrenNumber = childrenNumber
      // ..reactionsCount = reactionsCount
      // ..reactions = reactions
      ..myReactions = myReactions
      // ..latestReaction = latestReaction
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..editedAt = editedAt;
  }
}
