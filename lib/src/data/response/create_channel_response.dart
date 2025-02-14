// To parse this JSON data, do
//
//     final amityChannelResponse = amityChannelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/data/response/core_response/message_preview_response.dart';
import 'package:amity_sdk/src/data/response/core_response/subchannel_info_response.dart';
import 'package:amity_sdk/src/data/response/response.dart';

CreateChannelResponse amityChannelResponseFromJson(String str) =>
    CreateChannelResponse.fromJson(json.decode(str));

String amityChannelResponseToJson(CreateChannelResponse data) =>
    json.encode(data.toJson());

/// AmityChannelResponse
class CreateChannelResponse {
  /// init [CreateChannelResponse]
  CreateChannelResponse({
    required this.channels,
    required this.channelUsers,
    required this.users,
    required this.files,
    required this.paging,
    required this.messagePreviews,
    required this.subChannelInfo,
  });

  /// Channels
  final List<ChannelResponse> channels;

  /// Channel User
  final List<ChannelUserResponse> channelUsers;

  /// Users
  final List<UserResponse> users;

  /// Files
  final List<FileResponse> files;

  /// Paging
  final PagingResponse? paging;

  final List<MessagePreviewResponse> messagePreviews;

  final List<SubChannelInfoResponse> subChannelInfo;

  /// Get [CreateChannelResponse] from Map
  factory CreateChannelResponse.fromJson(Map<String, dynamic> json) =>
      CreateChannelResponse(
        channels: List<ChannelResponse>.from(
            json["channels"].map((x) => ChannelResponse.fromJson(x))),
        channelUsers: List<ChannelUserResponse>.from(
            json["channelUsers"].map((x) => ChannelUserResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        files: List<FileResponse>.from(
            json["files"].map((x) => FileResponse.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingResponse.fromJson(json['paging']),
        messagePreviews: List<MessagePreviewResponse>.from(
            json["messagePreviews"].map((x) => MessagePreviewResponse.fromJson(x))),
        subChannelInfo: List<SubChannelInfoResponse>.from(
            json["messageFeedsInfo"].map((x) => SubChannelInfoResponse.fromJson(x))),
      );

  /// Convert [CreateChannelResponse] to Map
  Map<String, dynamic> toJson() => {
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
        "channelUsers": List<dynamic>.from(channelUsers.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "paging": paging,
        "messagePreviews": List<dynamic>.from(messagePreviews.map((x) => x.toJson())),
        "messageFeedsInfo": List<dynamic>.from(subChannelInfo.map((x) => x.toJson())),
      };
}
