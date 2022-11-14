// To parse this JSON data, do
//
//      createChannelRequest = createChannelRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';

CreateChannelRequest createChannelRequestFromJson(String str) =>
    CreateChannelRequest.fromJson(json.decode(str));

String createChannelRequestToJson(CreateChannelRequest data) =>
    json.encode(data.toJson());

class CreateChannelRequest {
  CreateChannelRequest({
    this.channelId,
    this.type,
    this.displayName,
    this.avatarFileId,
    this.metadata,
    this.tags,
    this.userIds,
    this.isMuted,
    this.messageAutoDeleteEnabled,
    this.autoDeleteMessageByFlagLimit,
  });

  String? channelId;
  String? type;
  String? displayName;
  String? avatarFileId;
  Map<String, dynamic>? metadata;
  List<String>? tags;
  List<String>? userIds;
  bool? isMuted;
  bool? messageAutoDeleteEnabled;
  int? autoDeleteMessageByFlagLimit;

  factory CreateChannelRequest.fromJson(Map<String, dynamic> json) =>
      CreateChannelRequest(
        channelId: json["channelId"],
        type: json["type"],
        displayName: json["displayName"],
        avatarFileId: json["avatarFileId"],
        metadata: json["metadata"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        userIds: List<String>.from(json["userIds"].map((x) => x)),
        isMuted: json["isMuted"],
        messageAutoDeleteEnabled: json["messageAutoDeleteEnabled"],
        autoDeleteMessageByFlagLimit: json["autoDeleteMessageByFlagLimit"],
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "type": type,
        "displayName": displayName,
        "avatarFileId": avatarFileId,
        "metadata": metadata,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "userIds":
            userIds == null ? null : List<dynamic>.from(userIds!.map((x) => x)),
        "isMuted": isMuted,
        "messageAutoDeleteEnabled": messageAutoDeleteEnabled,
        "autoDeleteMessageByFlagLimit": autoDeleteMessageByFlagLimit,
      }..removeNullValue();
}
