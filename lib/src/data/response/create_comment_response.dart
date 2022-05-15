// To parse this JSON data, do
//
//     final createCommentResponse = createCommentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/data/response/core_response/core_response.dart';

CreateCommentResponse createCommentResponseFromJson(String str) =>
    CreateCommentResponse.fromJson(json.decode(str));

String createCommentResponseToJson(CreateCommentResponse data) =>
    json.encode(data.toJson());

class CreateCommentResponse {
  CreateCommentResponse({
    required this.comments,
    required this.commentChildren,
    required this.users,
    required this.files,
    required this.paging,
  });

  final List<CommentResponse> comments;
  final List<CommentResponse> commentChildren;
  final List<UserResponse> users;
  final List<FileResponse> files;
  final PagingResponse? paging;

  factory CreateCommentResponse.fromJson(Map<String, dynamic> json) =>
      CreateCommentResponse(
        comments: List<CommentResponse>.from(
            json["comments"].map((x) => CommentResponse.fromJson(x))),
        commentChildren: List<CommentResponse>.from(
            json["commentChildren"].map((x) => CommentResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        files: List<FileResponse>.from(
            json["files"].map((x) => FileResponse.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingResponse.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "commentChildren":
            List<dynamic>.from(commentChildren.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "paging": paging?.toJson(),
      };
}
