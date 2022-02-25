// To parse this JSON data, do
//
//     final createPostRequest = createPostRequestFromJson(jsonString);

import 'dart:convert';

CreatePostRequest createPostRequestFromJson(String str) =>
    CreatePostRequest.fromJson(json.decode(str));

String createPostRequestToJson(CreatePostRequest data) =>
    json.encode(data.toJson());

class CreatePostRequest {
  CreatePostRequest({
    this.data,
    this.attachments,
    this.dataType,
    required this.targetType,
    required this.targetId,
    this.metadata,
    this.postId,
  });

  CreatePostData? data;
  List<Attachment>? attachments;
  String? dataType;
  final String targetType;
  final String targetId;
  Metadata? metadata;
  String? postId;

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) =>
      CreatePostRequest(
        data: CreatePostData.fromJson(json["data"]),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        dataType: json["dataType"],
        targetType: json["targetType"],
        targetId: json["targetId"],
        metadata: Metadata.fromJson(json["metadata"]),
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "attachments": attachments == null
            ? null
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "dataType": dataType,
        "targetType": targetType,
        "targetId": targetId,
        "metadata": metadata == null ? null : metadata!.toJson(),
        "postId": postId,
      }..removeWhere((key, value) => value == null);
  @override
  String toString() {
    return createPostRequestToJson(this);
  }
}

class Attachment {
  Attachment({
    required this.fileId,
    required this.type,
  });

  final String fileId;
  final String type;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileId: json["fileId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "type": type,
      };
}

class CreatePostData {
  CreatePostData({
    this.text,
    this.streamId,
    this.pollId,
  });

  String? text;
  String? streamId;
  String? pollId;

  factory CreatePostData.fromJson(Map<String, dynamic> json) => CreatePostData(
        text: json["text"],
        streamId: json["streamId"],
        pollId: json["pollId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "streamId": streamId,
        "pollId": pollId,
      }..removeWhere((key, value) => value == null);
}

class Metadata {
  Metadata({
    required this.anything,
  });

  final String anything;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        anything: json["anything"],
      );

  Map<String, dynamic> toJson() => {
        "anything": anything,
      };
}
