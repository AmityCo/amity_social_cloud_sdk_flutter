// To parse this JSON data, do
//
//     final createMessageResponse = createMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/core_response/message_response.dart';

CreateMessageResponse createMessageResponseFromJson(String str) =>
    CreateMessageResponse.fromJson(json.decode(str));

String createMessageResponseToJson(CreateMessageResponse data) =>
    json.encode(data.toJson());

/// [CreateMessageResponse]
class CreateMessageResponse {
  /// init [CreateMessageResponse]
  CreateMessageResponse({
    required this.messages,
    required this.users,
    required this.files,
    required this.paging,
  });

  /// List of message
  final List<MessageResponse> messages;

  /// List of User
  final List<UserResponse> users;

  /// List of File
  final List<FileResponse> files;

  /// Paging
  final PagingResponse? paging;

  factory CreateMessageResponse.fromJson(Map<String, dynamic> json) =>
      CreateMessageResponse(
        messages: List<MessageResponse>.from(
            json["messages"].map((x) => MessageResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        files: List<FileResponse>.from(
            json["files"].map((x) => FileResponse.fromJson(x))),
        paging: PagingResponse.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "paging": paging?.toJson(),
      };
}
