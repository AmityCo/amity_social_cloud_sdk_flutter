import 'package:amity_sdk/src/core/core.dart';
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

  bool isMatchingFilter(MessageQueryRequest filter) {
    return channelId == filter.channelId &&
        _isDeletedCondition(filter) &&
        _parentCondition(filter) &&
        _typeCondition(filter) &&
        _includingTagCondition(filter) &&
        _excludingTagCondition(filter);
  }

  bool _isDeletedCondition(MessageQueryRequest request) {
    return request.isDeleted == null || request.isDeleted == isDeleted;
    // if (request.isDeleted == null) {
    //   //if isDeleted is not defined, return both isDeleted == true && isDeleted == false
    //   return true;
    // } else {
    //   //if isDeleted is defined, return request.isDeleted messages only
    //   return message.isDeleted == request.isDeleted;
    // }
  }

  bool _parentCondition(MessageQueryRequest request) {
    return request.parentId == null ||
        ((request.parentId != null && request.filterByParentId == true) &&
            request.parentId == parentId);
    // if (request.parentId != null && request.filterByParentId == true) {
    //   // if filterByParentId, return message with the parentId
    //   return parentId == request.parentId;
    // } else {
    //   // else retur  parent messages only, which parentId must be null
    //   return parentId == null;
    // }
  }

  bool _typeCondition(MessageQueryRequest request) {
    return request.type == null || request.type == type;
  }

  bool _includingTagCondition(MessageQueryRequest request) {
    return request.tags == null ||
        request.tags!.isEmpty ||
        (request.tags!).toSet().intersection((tags ?? []).toSet()).isNotEmpty;
  }

  bool _excludingTagCondition(MessageQueryRequest request) {
    return request.excludeTags == null ||
        request.excludeTags!.isEmpty ||
        (request.excludeTags!)
            .toSet()
            .intersection((tags ?? []).toSet())
            .isEmpty;
  }
}
