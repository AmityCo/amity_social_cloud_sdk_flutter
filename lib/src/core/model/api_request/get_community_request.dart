// To parse this JSON data, do
//
//     final getCommunityRequest = getCommunityRequestFromJson(jsonString);

import 'dart:convert';

import 'core/option_request.dart';

GetCommunityRequest getCommunityRequestFromJson(String str) =>
    GetCommunityRequest.fromJson(json.decode(str));

String getCommunityRequestToJson(GetCommunityRequest data) =>
    json.encode(data.toJson());

class GetCommunityRequest {
  GetCommunityRequest({
    this.keyword,
    this.tags,
    this.filter,
    this.categoryId,
    this.sortBy,
    this.isDeleted,
    this.hasFlag,
    this.options,
  });

  String? keyword;
  List<String>? tags;
  String? filter;
  String? categoryId;
  String? sortBy;
  bool? isDeleted;
  bool? hasFlag;
  OptionsRequest? options;

  factory GetCommunityRequest.fromJson(Map<String, dynamic> json) =>
      GetCommunityRequest(
        keyword: json["keyword"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        filter: json["filter"],
        categoryId: json["categoryId"],
        sortBy: json["sortBy"],
        isDeleted: json["isDeleted"],
        hasFlag: json["hasFlag"],
        options: OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "filter": filter,
        "categoryId": categoryId,
        "sortBy": sortBy,
        "isDeleted": isDeleted,
        "hasFlag": hasFlag,
        "options": options == null ? null : options!.toJson(),
      }..removeWhere((key, value) => value == null);
}
