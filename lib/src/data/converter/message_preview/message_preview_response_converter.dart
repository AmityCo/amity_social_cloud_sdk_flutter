import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';
import 'package:amity_sdk/src/data/response/core_response/message_preview_response.dart';
import 'package:amity_sdk/src/data/response/core_response/subchannel_info_response.dart';

class MessagePreviewResponseConverter {

  List<MessagePreviewHiveEntity> mapSubChannelInfoToMessagePreview(
    List<MessagePreviewResponse> messagePreviews,
    List<SubChannelInfoResponse> subChannelInfos) {
  return messagePreviews.fold<List<MessagePreviewHiveEntity>>([],
      (acc, preview) {
    final subChannelInfo = subChannelInfos
        .cast<SubChannelInfoResponse?>()
        .firstWhere(
            (subChannelInfo) =>
                subChannelInfo?.subChannelId == preview.subChannelId,
            orElse: () => null);
    if (subChannelInfo != null) {
      acc.add(map(preview, subChannelInfo));
    }
    return acc;
  });
}

MessagePreviewHiveEntity map(MessagePreviewResponse messagePreview,
      SubChannelInfoResponse subChannelInfo) {
    final preview = MessagePreviewHiveEntity(
      messagePreviewId: messagePreview.messagePreviewId,
      dataType: messagePreview.dataType,
      data: messagePreview.data?.convertToMesageDataHiveEntity(),
      channelId: messagePreview.channelId,
      subChannelId: messagePreview.subChannelId,
      subChannelName: subChannelInfo.subChannelName,
      subChannelUpdatedAt: subChannelInfo.updatedAt,
      creatorId: messagePreview.creatorId,
      isDeleted: messagePreview.isDeleted,
      segment: messagePreview.segment,
    );
    preview.createdAt = messagePreview.createdAt;
    preview.updatedAt = messagePreview.updatedAt;
    preview.subChannelUpdatedAt = subChannelInfo.updatedAt;
    return preview;
  }
}