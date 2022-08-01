// To parse this JSON data, do
//
//     final createPostRequest = createPostRequestFromJson(jsonString);

import 'dart:convert';

/// Create Post Request
class CreatePostRequest {
  /// Init [CreatePostRequest]
  CreatePostRequest({
    this.data,
    this.attachments,
    this.dataType,
    required this.targetType,
    required this.targetId,
    this.metadata,
    this.postId,
  });

  /// Post Data
  CreatePostData? data;

  /// Attachment for the Post
  List<Attachment>? attachments;

  /// Data type for the Post
  String? dataType;

  /// Target Type for the post
  final String targetType;

  /// Target id for the post
  final String targetId;

  /// Meta data for the post
  Map<String, dynamic>? metadata;

  /// Explicit post Id
  String? postId;

  /// Init [CreatePostRequest] from Json
  factory CreatePostRequest.fromJson(Map<String, dynamic> json) =>
      CreatePostRequest(
        data: CreatePostData.fromJson(json["data"]),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        dataType: json["dataType"],
        targetType: json["targetType"],
        targetId: json["targetId"],
        metadata: json["metadata"],
        postId: json["postId"],
      );

  /// map from [CreatePostRequest]
  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "attachments": attachments == null
            ? null
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "dataType": dataType,
        "targetType": targetType,
        "targetId": targetId,
        "metadata": metadata,
        "postId": postId,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return json.encode(toJson());
  }
}

/// Post Attachment
class Attachment {
  /// Init [Attachment]
  Attachment({
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

  /// Init [Attachment] from Json
  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileId: json["fileId"],
        videoFileId: json["videoFileId"],
        type: json["type"],
      );

  /// map from [Attachment]
  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "videoFileId": videoFileId,
        "type": type,
      }..removeWhere((key, value) => value == null);
}

/// Post Data
class CreatePostData {
  /// Init [CreatePostData]
  CreatePostData({
    this.text,
    this.streamId,
    this.pollId,
  });

  /// Text Data
  String? text;

  /// Stream Id
  String? streamId;

  /// Poll Id
  String? pollId;

  /// Init [CreatePostData] from Json
  factory CreatePostData.fromJson(Map<String, dynamic> json) => CreatePostData(
        text: json["text"],
        streamId: json["streamId"],
        pollId: json["pollId"],
      );

  /// map from [CreatePostData]
  Map<String, dynamic> toJson() => {
        "text": text,
        "streamId": streamId,
        "pollId": pollId,
      }..removeWhere((key, value) => value == null);
}
