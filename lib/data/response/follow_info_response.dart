// To parse this JSON data, do
//
//     final followInfoResponse = followInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/data/response/response.dart';

FollowInfoResponse followInfoResponseFromJson(String str) =>
    FollowInfoResponse.fromJson(json.decode(str));

String followInfoResponseToJson(FollowInfoResponse data) =>
    json.encode(data.toJson());

class FollowInfoResponse {
  FollowInfoResponse({
    required this.follows,
    required this.followCounts,
  });

  List<Follow>? follows;
  final List<FollowCount> followCounts;

  factory FollowInfoResponse.fromJson(Map<String, dynamic> json) =>
      FollowInfoResponse(
        follows: json["follows"] == null
            ? null
            : List<Follow>.from(json["follows"].map((x) => Follow.fromJson(x))),
        followCounts: List<FollowCount>.from(
            json["followCounts"].map((x) => FollowCount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "follows": follows == null
            ? null
            : List<dynamic>.from(follows!.map((x) => x.toJson())),
        "followCounts": List<dynamic>.from(followCounts.map((x) => x.toJson())),
      };
}

class FollowCount {
  FollowCount({
    required this.userId,
    required this.followerCount,
    required this.followingCount,
    required this.pendingCount,
  });

  final String userId;
  final int followerCount;
  final int followingCount;
  final int pendingCount;

  factory FollowCount.fromJson(Map<String, dynamic> json) => FollowCount(
        userId: json["userId"],
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        pendingCount: json["pendingCount"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "followerCount": followerCount,
        "followingCount": followingCount,
        "pendingCount": pendingCount,
      };
}
