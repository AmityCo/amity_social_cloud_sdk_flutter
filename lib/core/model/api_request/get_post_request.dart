// To parse this JSON data, do
//
//     final getPostRequest = getPostRequestFromJson(jsonString);

import 'dart:convert';

GetPostRequest getPostRequestFromJson(String str) =>
    GetPostRequest.fromJson(json.decode(str));

String getPostRequestToJson(GetPostRequest data) => json.encode(data.toJson());

class GetPostRequest {
  GetPostRequest({
    required this.targetId,
    required this.targetType,
    required this.sortBy,
    required this.hasFlag,
    required this.isDeleted,
    required this.options,
    required this.feedType,
    required this.dataTypes,
    required this.matchingOnlyParentPost,
  });

  final String targetId;
  final String targetType;
  final String sortBy;
  final dynamic hasFlag;
  final dynamic isDeleted;
  final Options options;
  final String feedType;
  final List<String> dataTypes;
  final bool matchingOnlyParentPost;

  factory GetPostRequest.fromJson(Map<String, dynamic> json) => GetPostRequest(
        targetId: json["targetId"],
        targetType: json["targetType"],
        sortBy: json["sortBy"],
        hasFlag: json["hasFlag"],
        isDeleted: json["isDeleted"],
        options: Options.fromJson(json["options"]),
        feedType: json["feedType"],
        dataTypes: List<String>.from(json["dataTypes"].map((x) => x)),
        matchingOnlyParentPost: json["matchingOnlyParentPost"],
      );

  Map<String, dynamic> toJson() => {
        "targetId": targetId,
        "targetType": targetType,
        "sortBy": sortBy,
        "hasFlag": hasFlag,
        "isDeleted": isDeleted,
        "options": options.toJson(),
        "feedType": feedType,
        "dataTypes": List<dynamic>.from(dataTypes.map((x) => x)),
        "matchingOnlyParentPost": matchingOnlyParentPost,
      };
}

class Options {
  Options({
    required this.limit,
    required this.token,
  });

  final int limit;
  final String token;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        limit: json["limit"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "token": token,
      };
}
