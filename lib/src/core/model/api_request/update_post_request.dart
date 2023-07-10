// To parse this JSON data, do
//
//     final updatePostRequest = updatePostRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/domain/domain.dart';

import 'create_post_request.dart';

UpdatePostRequest updatePostRequestFromJson(String str) => UpdatePostRequest.fromJson(json.decode(str));

String updatePostRequestToJson(UpdatePostRequest data) => json.encode(data.toJson());

class UpdatePostRequest {
  UpdatePostRequest({required this.postId, this.data, this.metadata, this.mentionees, this.attachments});

  String postId;
  UpdatePostData? data;
  Map<String, dynamic>? metadata;

  /// Mentionees
  List<AmityMentioneeTarget>? mentionees;

  /// Attachment for the Post
  List<PostAttachmentRequest>? attachments;

  factory UpdatePostRequest.fromJson(Map<String, dynamic> json) => UpdatePostRequest(
        postId: json["postId"],
        data: UpdatePostData.fromJson(json["data"]),
        metadata: json["metadata"],
        mentionees: List<AmityMentioneeTarget>.from(json["mentionees"].map((x) => AmityMentioneeTarget.fromJson(x))),
        attachments:
            List<PostAttachmentRequest>.from(json["attachments"].map((x) => PostAttachmentRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "data": data?.toJson(),
        "metadata": metadata,
        "mentionees": mentionees == null ? null : List<dynamic>.from(mentionees!.map((x) => x.toJson())),
        "attachments": attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      }..removeWhere((key, value) => value == null);
}

class UpdatePostData {
  UpdatePostData({
    this.text,
    this.fileId,
    this.streamId,
    this.thumbnailFileId,
  });

  String? text;
  String? fileId;
  String? streamId;
  String? thumbnailFileId;

  factory UpdatePostData.fromJson(Map<String, dynamic> json) => UpdatePostData(
        text: json["text"],
        fileId: json["fileId"],
        streamId: json["streamId"],
        thumbnailFileId: json["thumbnailFileId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "fileId": fileId,
        "streamId": streamId,
        "thumbnailFileId": thumbnailFileId,
      }..removeWhere((key, value) => value == null);
}
