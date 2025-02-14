import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message_preview.dart';

/// [MessageHiveExtensionConverter]
extension MessagePreviewHiveExtensionConverter on MessagePreviewHiveEntity {
  ///
  AmityMessagePreview convertToAmityMessagePreview() {
    //Data type
    AmityMessageDataType amityMessageDataType = dataType != null ? AmityMessageDataTypeExtension.enumOf(dataType!) : AmityMessageDataType.TEXT;

    AmityMessageData? amityMessageData;
    switch (amityMessageDataType) {
      case AmityMessageDataType.TEXT:
        amityMessageData =
            MessageTextData(messageId: messagePreviewId!, text: data!.text);
        break;
      case AmityMessageDataType.IMAGE:
        amityMessageData = MessageImageData(
          messageId: messagePreviewId!,
          fileId: null,
          caption: data!.caption,
        );
        break;
      case AmityMessageDataType.AUDIO:
        amityMessageData = MessageAudioData(
          messageId: messagePreviewId!,
          fileId: null,
        );
        break;
      case AmityMessageDataType.FILE:
        amityMessageData = MessageFileData(
          messageId: messagePreviewId!,
          fileId: null,
          caption: data!.caption,
        );
        break;
      
      case AmityMessageDataType.VIDEO:
        amityMessageData = MessageVideoData(
          messageId: messagePreviewId!,
          fileId: null,
          rawData: data!.toMap(),
        );
        break;
      case AmityMessageDataType.CUSTOM:
        amityMessageData = MessageCustomData(
          messageId: messagePreviewId!,
          rawData: data!.toMap(),
        );
        break;
    }
    
    return AmityMessagePreview(
      messagePreviewId: messagePreviewId!,
      dataType: amityMessageDataType,
      data: amityMessageData,
      rawData: data?.toMap() ?? {},
      channelId: channelId!,
      subChannelId: subChannelId ?? "",
      subChannelName: subChannelName ?? "",
      userId: creatorId!,
      isDeleted: isDeleted!,
      segment: segment!,
      createdAt: createdAt!,
      updatedAt: updatedAt!,
    );
      
  }
}
