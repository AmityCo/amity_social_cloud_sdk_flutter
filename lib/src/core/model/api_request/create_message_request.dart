// To parse this JSON data, do
//
//     final createMessageRequest = createMessageRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

CreateMessageRequest createMessageRequestFromJson(String str) =>
    CreateMessageRequest.fromJson(json.decode(str));

String createMessageRequestToJson(CreateMessageRequest data) =>
    json.encode(data.toJson());

/// [CreateMessageRequest]
class CreateMessageRequest {
  /// init [CreateMessageRequest]
  CreateMessageRequest({
    required this.channelId,
    this.messageId,
    this.type,
    this.data,
    this.fileId,
    this.parentId,
    this.metadata,
    this.tags,
    this.mentionees,
  });

  /// Channel ID
  final String channelId;

  /// Message ID
  String? messageId;

  /// Type
  String? type;

  /// Data
  CreateMessageData? data;

  /// File Id
  String? fileId;

  /// Parent Id
  String? parentId;

  /// Metadata
  Map<String, dynamic>? metadata;

  /// Tags
  List<String>? tags;

  /// Mentionees
  List<AmityMentioneeTarget>? mentionees;

  factory CreateMessageRequest.fromJson(Map<String, dynamic> json) =>
      CreateMessageRequest(
        channelId: json["channelId"],
        messageId: json["messageId"],
        type: json["type"],
        data: json["data"] == null
            ? null
            : CreateMessageData.fromJson(json["data"]),
        fileId: json["fileId"],
        parentId: json["parentId"],
        metadata: json["metadata"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        mentionees: List<AmityMentioneeTarget>.from(
            json["mentionees"].map((x) => AmityMentioneeTarget.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "messageId": messageId,
        "type": type,
        "data": data == null ? null : data!.toJson(),
        "fileId": fileId,
        "parentId": parentId,
        "metadata": metadata,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "mentionees": mentionees == null
            ? null
            : List<AmityMentioneeTarget>.from(
                mentionees!.map((x) => x.toJson())),
      }..removeNullValue();
}

///[CreateMessageData]
class CreateMessageData {
  /// Init [CreateMessageData]
  CreateMessageData({
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

  /// Init [CreateMessageData] from Json
  factory CreateMessageData.fromJson(Map<String, dynamic> json) =>
      CreateMessageData(
        text: json["text"],
        streamId: json["streamId"],
        pollId: json["pollId"],
      );

  /// map from [CreateMessageData]
  Map<String, dynamic> toJson() => {
        "text": text,
        "streamId": streamId,
        "pollId": pollId,
      }..removeWhere((key, value) => value == null);
}
