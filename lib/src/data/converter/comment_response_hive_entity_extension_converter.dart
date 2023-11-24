import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/model.dart';
import 'package:amity_sdk/src/src.dart';

/// CommentHiveEntityExtension
extension CommentHiveEntityExtension on CommentHiveEntity {
  /// Convert [CommentHiveEntity] to [AmityComment]
  AmityComment convertToAmityComment() {
    AmityCommentReferenceType amityCommentReferenceType =
        AmityCommentReferenceTypeExtension.enumOf(referenceType!);
    AmityCommentTarget amityCommentTarget = UnknownCommentTarget();
    if (targetId != null && targetType != null) {
      AmityCommentTargetType amityCommentTargetType =
          AmityCommentTargetTypeExtension.enumOf(targetType!);
      
      switch (amityCommentTargetType) {
        case AmityCommentTargetType.COMMUNITY:
          amityCommentTarget = CommunityCommentTarget(
            type: targetType,
            communityId: targetId,
          );
          break;
        case AmityCommentTargetType.USER:
          amityCommentTarget =
              UserCommentTarget(userId: targetId, type: targetType);

          break;
        case AmityCommentTargetType.CONTENT:
          amityCommentTarget =
              ContentCommentTarget(contentId: targetId, type: targetType);
          break;
        case AmityCommentTargetType.UNKNOWN:
          amityCommentTarget = UnknownCommentTarget();
          break;
      }

    }

    //Data type
    AmityDataType amityCommentType = AmityDataTypeExtension.enumOf(dataType!);
    AmityCommentData? amityCommentData;
    switch (amityCommentType) {
      case AmityDataType.TEXT:
        amityCommentData =
            CommentTextData(commentId: commentId, text: data!.text);
        break;
      case AmityDataType.IMAGE:
        amityCommentData =
            CommentImageData(commentId: commentId, fileId: data!.fileId);
        break;
      case AmityDataType.VIDEO:
        amityCommentData = CommentVideoData(
          commentId: commentId,
          fileId: data!.thumbnailFileId,
          rawData: data?.videoFileId,
        );
        break;
      case AmityDataType.FILE:
        amityCommentData =
            CommentFileData(commentId: commentId, fileId: data!.fileId);
        break;
      case AmityDataType.LIVESTREAM:
        // TODO: Handle this case.
        break;
      case AmityDataType.POLL:
        // TODO: Handle this case.
        break;
      case AmityDataType.CUSTOM:
        // TODO: Handle this case.
        break;
    }

    ///Mentionees
    List<AmityMentionee>? mentionees;

    if (this.mentionees != null) {
      for (Mentionee mentionee in this.mentionees!) {
        if (mentionee.type == 'user') {
          mentionees =
              mentionee.userIds!.map((e) => AmityMentionee(userId: e)).toList();
        }
      }
    }

    ///Attachments
    List<CommentAttachment>? attachments;

    if (this.attachments != null) {
      for (AttachmentResponse attachment in this.attachments!) {
        if (attachment.type.toUpperCase() ==
            AmityDataType.IMAGE.value.toUpperCase()) {
          (attachments ??= [])
              .add(CommentImageAttachment(fileId: attachment.fileId));
        }
      }
    }

    return AmityComment(commentId: commentId)
      ..referenceType = amityCommentReferenceType
      ..referenceId = referenceId
      ..userId = userId
      ..parentId = parentId
      ..dataType = amityCommentType
      ..dataTypes = dataTypes
      ..data = amityCommentData
      ..childrenNumber = childrenNumber
      ..repliesId = children
      ..flagCount = flagCount
      ..reactions = AmityReactionMap(reactions: reactions)
      ..myReactions = myReactions
      ..hashFlag = hashFlag
      ..reactionCount = reactionsCount
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = editedAt
      ..updatedAt = updatedAt
      ..path = path
      ..metadata = metadata
      ..flaggedByMe = flaggedByMe
      ..mentionees = mentionees
      ..attachments = attachments
      ..target = amityCommentTarget;
  }
}
