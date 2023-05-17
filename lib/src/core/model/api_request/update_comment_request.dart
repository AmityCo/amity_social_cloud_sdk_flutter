// To parse this JSON data, do
//
//     final updateCommentRequest = updateCommentRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/src.dart';

UpdateCommentRequest updateCommentRequestFromJson(String str) => UpdateCommentRequest.fromJson(json.decode(str));

String updateCommentRequestToJson(UpdateCommentRequest data) => json.encode(data.toJson());

class UpdateCommentRequest {
  UpdateCommentRequest({
    required this.commentId,
    this.data,
    this.metadata,
    this.attachments,
  });

  String commentId;
  UpdateCommentData? data;
  Map<String, dynamic>? metadata;

  /// Mentionees
  List<AmityMentioneeTarget>? mentionees;

  /// Attachment for the comment
  List<CommentAttachmentRequest>? attachments;

  factory UpdateCommentRequest.fromJson(Map<String, dynamic> json) => UpdateCommentRequest(
        commentId: json["commentId"],
        data: UpdateCommentData.fromJson(json["data"]),
        metadata: json["metadata"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "data": data?.toJson(),
        "metadata": metadata,
        "mentionees": mentionees == null ? null : List<dynamic>.from(mentionees!.map((x) => x.toJson())),
        //Send attachments as blank array, in case want to remove all attachments
        "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      }..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class UpdateCommentData {
  UpdateCommentData({
    this.text,
  });

  String? text;

  factory UpdateCommentData.fromJson(Map<String, dynamic> json) => UpdateCommentData(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      }..removeNullValue();

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
