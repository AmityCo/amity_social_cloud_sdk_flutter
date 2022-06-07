// To parse this JSON data, do
//
//     final userFeedRequest = userFeedRequestFromJson(jsonString);

import 'dart:convert';

import 'core/option_request.dart';

GetCommunityFeedRequest userFeedRequestFromJson(String str) =>
    GetCommunityFeedRequest.fromJson(json.decode(str));

String userFeedRequestToJson(GetCommunityFeedRequest data) =>
    json.encode(data.toJson());

class GetCommunityFeedRequest {
  GetCommunityFeedRequest(
      {required this.communityId,
      this.sortBy,
      this.isDeleted,
      this.hasFlag,
      this.options,
      this.dataTypes,
      this.matchingOnlyParentPost});

  final String communityId;
  String? sortBy;
  bool? isDeleted;
  bool? hasFlag;
  OptionsRequest? options;
  List<String>? dataTypes;
  bool? matchingOnlyParentPost;

  factory GetCommunityFeedRequest.fromJson(Map<String, dynamic> json) =>
      GetCommunityFeedRequest(
        communityId: json["communityId"],
        sortBy: json["sortBy"],
        isDeleted: json["isDeleted"],
        hasFlag: json["hasFlag"],
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
        dataTypes: List<String>.from(json["dataTypes"].map((x) => x)),
        matchingOnlyParentPost: json["matchingOnlyParentPost"],
      );

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "sortBy": sortBy,
        "isDeleted": isDeleted,
        "hasFlag": hasFlag,
        "options": options?.toJson(),
        "dataTypes": dataTypes == null
            ? null
            : List<dynamic>.from(dataTypes!.map((x) => x)),
        "matchingOnlyParentPost": false,
      }..removeWhere((key, value) => value == null);
}
