// To parse this JSON data, do
//
//     final amityChannelResponse = amityChannelResponseFromJson(jsonString);

import 'dart:convert';

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
      );

  /// Convert [CreateChannelResponse] to Map
  Map<String, dynamic> toJson() => {
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
        "channelUsers": List<dynamic>.from(channelUsers.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "paging": paging,
      };
}
