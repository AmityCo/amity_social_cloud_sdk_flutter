import 'package:amity_sdk/src/data/converter/message/message.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';
import 'package:amity_sdk/src/data/response/core_response/message_preview_response.dart';
import 'package:amity_sdk/src/data/response/core_response/sub_channel_response.dart';
import 'package:amity_sdk/src/data/response/core_response/subchannel_info_response.dart';
import 'package:amity_sdk/src/data/response/response.dart';

extension MessagePreviewResponseExtensionConverter on MessagePreviewResponse {
  MessagePreviewHiveEntity convertToMessagePreviewHiveEntity() {
    return MessagePreviewHiveEntity()
      ..messagePreviewId = messagePreviewId
      ..dataType = dataType
      ..data = data?.convertToMesageDataHiveEntity()
      ..channelId = channelId
      ..subChannelId = subChannelId
      ..creatorId = creatorId
      ..isDeleted = isDeleted
      ..segment = segment
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }

  SubChannelInfoResponse toSubChannelInfo(SubChannelResponse subChannel) {
    return SubChannelInfoResponse(
      subChannelId: subChannelId,
      subChannelName: subChannel.name ?? "",
      createdAt: subChannel.createdAt,
      updatedAt: subChannel.updatedAt,
    );
  }
}
