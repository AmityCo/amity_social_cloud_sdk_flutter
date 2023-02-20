import 'package:amity_sdk/src/data/converter/message/message_data_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';
import 'package:amity_sdk/src/data/response/response.dart';

/// [MessageResponseExtensionConverter]
extension MessageResponseExtensionConverter on MessageResponse {
  /// Convert [MessageResponse] to [MessageHiveEntity]
  MessageHiveEntity convertToMesageHiveEntity() {
    return MessageHiveEntity()
      ..messageId = messageId
      ..channelId = channelId
      ..userId = userId
      ..type = type
      ..data = data.convertToMesageDataHiveEntity()
      ..channelSegment = channelSegment
      ..parentId = parentId
      ..fileId = fileId
      ..tags = tags
      ..metadata = metadata
      ..flagCount = flagCount
      ..hashFlag = hashFlag?.toJson()
      ..childrenNumber = childrenNumber
      ..reactionsCount = reactionsCount
      ..reactions = reactions
      ..myReactions = myReactions
      ..latestReaction = latestReaction
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..editedAt = editedAt
      ..mentionees = mentionees;
  }
}
