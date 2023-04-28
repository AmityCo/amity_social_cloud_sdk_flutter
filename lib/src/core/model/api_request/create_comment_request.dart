// To parse this JSON data, do
//
//     final createCommentRequest = createCommentRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/extension/extension.dart';
import 'package:amity_sdk/src/domain/domain.dart';

String createCommentRequestToJson(CreateCommentRequest data) => json.encode(data.toJson());

class CreateCommentRequest {
  CreateCommentRequest(
      {required this.referenceId,
      required this.referenceType,
      this.data,
      this.metadata,
      this.commentId,
      this.parentId,
      this.mentionees,
      this.attachments});

  final String referenceId;
  final String referenceType;
  CreateCommentData? data;
  Map<String, dynamic>? metadata;
  String? commentId;
  String? parentId;

  /// Mentionees
  List<AmityMentioneeTarget>? mentionees;

  /// Attachment for the comment
  List<CommentAttachmentRequest>? attachments;

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "data": data!.toJson(),
        "metadata": metadata,
        "commentId": commentId,
        "parentId": parentId,
        "mentionees": mentionees == null ? null : List<dynamic>.from(mentionees!.map((x) => x.toJson())),
        "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => 'CreateCommentRequest(referenceId: $referenceId, referenceType: $referenceType)';
}

class CreateCommentData {
  CreateCommentData({
    this.text,
  });

  String? text;

  factory CreateCommentData.fromJson(Map<String, dynamic> json) => CreateCommentData(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      }..removeWhere((key, value) => value == null);
}

/// Comment Attachment
class CommentAttachmentRequest {
  /// Init [CommentAttachmentRequest]
  CommentAttachmentRequest({
    this.fileId,
    this.videoFileId,
    required this.type,
  });

  /// File Id
  final String? fileId;

  /// Video File Id
  final String? videoFileId;

  /// Type for data
  final String type;

  /// map from [CommentAttachmentRequest]
  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "videoFileId": videoFileId,
        "type": type,
      }..removeNullValue();
}
