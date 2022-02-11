// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/data/response/core_response/file_response.dart';
import 'package:amity_sdk/data/response/core_response/pagin_response.dart';
import 'package:amity_sdk/data/response/response.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    required this.users,
    required this.files,
    this.paging,
  });

  final List<UserResponse> users;
  final List<FileResponse> files;
  Paging? paging;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        files: List<FileResponse>.from(
            json["files"].map((x) => FileResponse.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "paging": paging == null ? null : paging!.toJson(),
      };
}
