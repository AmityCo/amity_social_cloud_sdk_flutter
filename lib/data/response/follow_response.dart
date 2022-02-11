// To parse this JSON data, do
//
//     final followResponse = followResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/data/response/core_response/file_response.dart';
import 'package:amity_sdk/data/response/response.dart';

import 'core_response/pagin_response.dart';

FollowResponse followResponseFromJson(String str) =>
    FollowResponse.fromJson(json.decode(str));

String followResponseToJson(FollowResponse data) => json.encode(data.toJson());

class FollowResponse {
  FollowResponse({
    required this.follows,
    required this.users,
    required this.files,
    required this.paging,
  });

  final List<Follow> follows;
  final List<UserResponse>? users;
  final List<FileResponse>? files;
  final Paging? paging;

  factory FollowResponse.fromJson(Map<String, dynamic> json) => FollowResponse(
        follows:
            List<Follow>.from(json["follows"].map((x) => Follow.fromJson(x))),
        users: json["users"] == null
            ? null
            : List<UserResponse>.from(
                json["users"].map((x) => UserResponse.fromJson(x))),
        files: json["files"] == null
            ? null
            : List<FileResponse>.from(
                json["files"].map((x) => FileResponse.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "follows": List<dynamic>.from(follows.map((x) => x.toJson())),
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "files": files == null
            ? null
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "paging": paging == null ? null : paging!.toJson(),
      };
}

class Follow {
  Follow({
    required this.from,
    required this.to,
    required this.status,
  });

  final String from;
  final String to;
  final String status;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        from: json["from"],
        to: json["to"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "status": status,
      };
}
