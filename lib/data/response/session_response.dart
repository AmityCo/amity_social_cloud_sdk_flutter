// To parse this JSON data, do
//
//     final sessionResponse = sessionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/data/response/response.dart';

SessionResponse sessionResponseFromJson(String str) =>
    SessionResponse.fromJson(json.decode(str));

String sessionResponseToJson(SessionResponse data) =>
    json.encode(data.toJson());

class SessionResponse {
  SessionResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.users,
    required this.files,
  });

  final String accessToken;
  final String refreshToken;
  final List<UserResponse> users;
  final List<dynamic> files;

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      SessionResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        files: List<dynamic>.from(json["files"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
