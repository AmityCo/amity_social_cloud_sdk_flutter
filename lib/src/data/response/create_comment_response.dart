import 'dart:convert';

import 'package:amity_sdk/src/data/response/core_response/base_reponse.dart';
import 'package:amity_sdk/src/data/response/core_response/core_response.dart';
import 'package:amity_sdk/src/data/response/reaction_related_response.dart';

CreateCommentResponse createCommentResponseFromJson(String str) =>
    CreateCommentResponse.fromJson(json.decode(str));

String createCommentResponseToJson(CreateCommentResponse data) =>
    json.encode(data.toJson());

class CreateCommentResponse with ReactionRelatedResponse {
  CreateCommentResponse({
    required this.comments,
    required this.commentChildren,
    required this.users,
    required this.files,
    required this.communityUsers,
    required this.reactor,
    required this.paging,
  });

  final List<CommentResponse> comments;
  final List<CommentResponse> commentChildren;
  final List<UserResponse> users;
  final List<FileResponse> files;
  final PagingResponse? paging;
  final List<CommunityUserResponse> communityUsers;
  final Reactor? reactor;

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
        communityUsers: json["communityUsers"] == null
            ? []
            : List<CommunityUserResponse>.from(json["communityUsers"]
                .map((x) => CommunityUserResponse.fromJson(x))),
        reactor: json["reactor"] == null
            ? null
            : Reactor.fromJson(json['reactor']),
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
        "communityUsers":
            List<dynamic>.from(communityUsers.map((x) => x.toJson())),
        "reactor": reactor?.toJson(),
        "paging": paging?.toJson(),
      };

  @override
  List<BaseResponse> getResponses() {
    return comments;
  }
}
