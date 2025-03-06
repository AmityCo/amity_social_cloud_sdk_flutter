// To parse this JSON data, do
//
//     final createMessageResponse = createMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/core_response/base_reponse.dart';
import 'package:amity_sdk/src/data/response/core_response/sub_channel_response.dart';
import 'package:amity_sdk/src/data/response/reaction_related_response.dart';

CreateMessageResponse createMessageResponseFromJson(String str) =>
    CreateMessageResponse.fromJson(json.decode(str));

String createMessageResponseToJson(CreateMessageResponse data) =>
    json.encode(data.toJson());

/// [CreateMessageResponse]
class CreateMessageResponse with ReactionRelatedResponse {
  /// init [CreateMessageResponse]
  CreateMessageResponse({
    required this.messages,
    required this.users,
    required this.files,
    required this.reactions,
    required this.reactor,
    required this.subChannels,
    required this.paging,
  });

  /// List of message
  final List<MessageResponse> messages;

  /// List of User
  final List<UserResponse> users;

  /// List of File
  final List<FileResponse> files;

  final List<Reactor> reactions;

  final Reactor? reactor;

  final List<SubChannelResponse> subChannels;

  /// Paging
  final PagingResponse? paging;

  factory CreateMessageResponse.fromJson(Map<String, dynamic> json) {
    var reactions = List.empty();
    try {
      reactions = json['reactions'];
    } catch (e) {
      // No reactions from response
    }
    return CreateMessageResponse(
      messages: List<MessageResponse>.from(
          json["messages"].map((x) => MessageResponse.fromJson(x))),
      users: List<UserResponse>.from(
          json["users"].map((x) => UserResponse.fromJson(x))),
      files: List<FileResponse>.from(
          json["files"].map((x) => FileResponse.fromJson(x))),
      reactions: List<Reactor>.from(
          reactions.map((x) => Reactor.fromJson(x))),
        reactor: json["reactor"] == null
            ? null
            : Reactor.fromJson(json['reactor']),
      subChannels: List<SubChannelResponse>.from(
          json["messageFeeds"].map((x) => SubChannelResponse.fromJson(x))),
      paging: json["paging"] == null
          ? null
          : PagingResponse.fromJson(json["paging"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "reactions": List<dynamic>.from(reactions.map((x) => x.toJson())),
        "subChannels": List<dynamic>.from(subChannels.map((x) => x.toJson())),
        "reactor": reactor?.toJson(),
        "paging": paging?.toJson(),
      };

  @override
  List<BaseResponse> getResponses() {
    return messages;
  }
}
