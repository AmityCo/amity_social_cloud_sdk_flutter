// To parse this JSON data, do
//
//     final getReactionResponse = getReactionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/data/data.dart';

GetReactionResponse getReactionResponseFromJson(String str) =>
    GetReactionResponse.fromJson(json.decode(str));

String getReactionResponseToJson(GetReactionResponse data) =>
    json.encode(data.toJson());

class GetReactionResponse {
  GetReactionResponse({
    required this.reactions,
    required this.users,
    required this.paging,
  });


  final PagingResponse paging;
  final List<ReactionResponse> reactions;
  final List<UserResponse> users;

  factory GetReactionResponse.fromJson(Map<String, dynamic> json) =>
      GetReactionResponse(
         reactions: List<ReactionResponse>.from(
            json["reactions"].map((x) => ReactionResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        paging: PagingResponse.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "reactions": List<dynamic>.from(reactions.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "paging": paging.toJson(),
      };
}

class Results {
  Results({
    required this.reactions,
    required this.users,
  });

  final List<ReactionResponse> reactions;
  final List<UserResponse> users;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        reactions: List<ReactionResponse>.from(
            json["reactions"].map((x) => ReactionResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reactions": List<dynamic>.from(reactions.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
