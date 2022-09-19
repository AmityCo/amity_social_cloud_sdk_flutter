// To parse this JSON data, do
//
//     final getChannelRequest = getChannelRequestFromJson(jsonString);

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
    required this.keyword,
    required this.isDeleted,
    required this.tags,
    required this.excludeTags,
    required this.filter,
    required this.types,
    required this.userId,
    required this.sortBy,
    required this.options,
  });

  /// Keyword
  final String keyword;

  /// Is Deleted
  final bool? isDeleted;

  /// Tags
  final List<String>? tags;

  /// Excludes Tags
  final List<String>? excludeTags;

  /// Filter
  final String? filter;

  /// Types
  final List<String>? types;

  /// User ID
  final String? userId;

  /// Sort By
  final String? sortBy;

  /// Options
  final OptionsRequest? options;

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
        "tags": List<dynamic>.from(tags?.map((x) => x) ?? []),
        "excludeTags": List<dynamic>.from(excludeTags?.map((x) => x) ?? []),
        "filter": filter,
        "types": List<dynamic>.from(types?.map((x) => x) ?? []),
        "userId": userId,
        "sortBy": sortBy,
        "options": options?.toJson(),
      };
}
