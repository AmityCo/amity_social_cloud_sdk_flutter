// To parse this JSON data, do
//
//      getChannelRequest = getChannelRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';

GetChannelRequest getChannelRequestFromJson(String str) =>
    GetChannelRequest.fromJson(json.decode(str));

String getChannelRequestToJson(GetChannelRequest data) =>
    json.encode(data.toJson());

/// [GetChannelRequest]
class GetChannelRequest {
  /// Init [GetChannelRequest]
  GetChannelRequest({
    this.keyword,
    this.isDeleted,
    this.tags,
    this.excludeTags,
    this.filter,
    this.types,
    this.userId,
    this.sortBy,
    this.options,
  });

  /// Keyword
  String? keyword;

  /// Is Deleted
  bool? isDeleted;

  /// Tags
  List<String>? tags;

  /// Excludes Tags
  List<String>? excludeTags;

  /// Filter
  String? filter;

  /// Types
  List<String>? types;

  /// User ID
  String? userId;

  /// Sort By
  String? sortBy;

  /// Options
  OptionsRequest? options;

  /// [GetChannelRequest] from  Map
  factory GetChannelRequest.fromJson(Map<String, dynamic> json) =>
      GetChannelRequest(
        keyword: json["keyword"],
        isDeleted: json["isDeleted"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        excludeTags: List<String>.from(json["excludeTags"].map((x) => x)),
        filter: json["filter"],
        types: List<String>.from(json["types"].map((x) => x)),
        userId: json["userId"],
        sortBy: json["sortBy"],
        options: OptionsRequest.fromJson(json["options"]),
      );

  /// Map from [GetChannelRequest]
  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "isDeleted": isDeleted,
        "tags": tags == null ? null : List<String>.from(tags!.map((x) => x)),
        "excludeTags": excludeTags == null
            ? null
            : List<String>.from(excludeTags!.map((x) => x)),
        "filter": filter,
        "types[]":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
        "userId": userId,
        "sortBy": sortBy,
        "options": options?.toJson(),
      }..removeNullValue();
}
