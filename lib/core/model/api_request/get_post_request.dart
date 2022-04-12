// To parse this JSON data, do
//
//     final getPostRequest = getPostRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/core/model/api_request/core/option_request.dart';

GetPostRequest getPostRequestFromJson(String str) =>
    GetPostRequest.fromJson(json.decode(str));

String getPostRequestToJson(GetPostRequest data) => json.encode(data.toJson());

class GetPostRequest {
  GetPostRequest({
    required this.targetId,
    required this.targetType,
    this.sortBy,
    this.hasFlag,
    this.isDeleted,
    this.options,
    this.feedType,
    this.dataTypes,
    this.matchingOnlyParentPost,
  });

  final String targetId;
  final String targetType;
  String? sortBy;
  bool? hasFlag;
  bool? isDeleted;
  OptionsRequest? options;
  String? feedType;
  List<String>? dataTypes;
  bool? matchingOnlyParentPost;

  factory GetPostRequest.fromJson(Map<String, dynamic> json) => GetPostRequest(
        targetId: json["targetId"],
        targetType: json["targetType"],
        sortBy: json["sortBy"],
        hasFlag: json["hasFlag"],
        isDeleted: json["isDeleted"],
        options: OptionsRequest.fromJson(json["options"]),
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
        "options": options == null ? null : options!.toJson(),
        "feedType": feedType,
        "dataTypes": dataTypes == null
            ? null
            : List<dynamic>.from(dataTypes!.map((x) => x)),
        "matchingOnlyParentPost": matchingOnlyParentPost,
      }..removeWhere((key, value) => value == null);
}
