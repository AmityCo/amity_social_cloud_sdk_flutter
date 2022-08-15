// To parse this JSON data, do
//
//     final messageQueryRequest = messageQueryRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';

MessageQueryRequest messageQueryRequestFromJson(String str) =>
    MessageQueryRequest.fromJson(json.decode(str));

String messageQueryRequestToJson(MessageQueryRequest data) =>
    json.encode(data.toJson());

/// [MessageQueryRequest]
class MessageQueryRequest {
  /// init [MessageQueryRequest]
  MessageQueryRequest({
    required this.channelId,
    this.type,
    this.parentId,
    this.filterByParentId,
    this.hasFlag,
    this.isDeleted,
    this.tags,
    this.excludeTags,
    this.options,
  });

  /// Channel ID
  final String channelId;

  /// Type
  String? type;

  /// Parent ID
  String? parentId;

  /// Filter By Parent Id
  bool? filterByParentId;

  /// Hash flag
  bool? hasFlag;

  /// Is Deleted
  bool? isDeleted;

  /// Tags
  List<String>? tags;

  /// Exclude Tags
  List<String>? excludeTags;

  /// Option
  OptionsRequest? options;

  /// [MessageQueryRequest]
  factory MessageQueryRequest.fromJson(Map<String, dynamic> json) =>
      MessageQueryRequest(
        channelId: json["channelId"],
        type: json["type"],
        parentId: json["parentId"],
        filterByParentId: json["filterByParentId"],
        hasFlag: json["hasFlag"],
        isDeleted: json["isDeleted"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        excludeTags: List<String>.from(json["excludeTags"].map((x) => x)),
        options: OptionsRequest.fromJson(json["options"]),
      );

  /// Convert [MessageQueryRequest] to Map
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "type": type,
        "parentId": parentId,
        "filterByParentId": filterByParentId,
        "hasFlag": hasFlag,
        "isDeleted": isDeleted,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "excludeTags": excludeTags == null
            ? null
            : List<dynamic>.from(excludeTags!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}

/// [_Options]
class _Options {
  /// init [_Options]
  _Options(
      {required this.after,
      required this.first,
      required this.before,
      required this.last,
      required this.token,
      required this.limit});

  /// After
  final int after;

  /// First
  final int first;

  /// Before
  final int before;

  /// Last
  final int last;

  /// Token
  String token;

  int limit;

  factory _Options.fromJson(Map<String, dynamic> json) => _Options(
        after: json["after"],
        first: json["first"],
        before: json["before"],
        last: json["last"],
        token: json["token"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "after": after,
        "first": first,
        "before": before,
        "last": last,
        "token": token,
        "limit": limit,
      };
}
