// To parse this JSON data, do
//
//     final getCommentRequest = getCommentRequestFromJson(jsonString);

import 'dart:convert';

GetCommentRequest getCommentRequestFromJson(String str) =>
    GetCommentRequest.fromJson(json.decode(str));

String getCommentRequestToJson(GetCommentRequest data) =>
    json.encode(data.toJson());

class GetCommentRequest {
  GetCommentRequest({
    required this.referenceId,
    required this.referenceType,
    this.filterByParentId,
    this.parentId,
    this.hasFlag,
    this.isDeleted,
    this.sortBy,
    this.options,
  });

  final String referenceId;
  final String referenceType;
  bool? filterByParentId;
  String? parentId;
  bool? hasFlag;
  bool? isDeleted;
  String? sortBy;
  Options? options;

  factory GetCommentRequest.fromJson(Map<String, dynamic> json) =>
      GetCommentRequest(
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
        filterByParentId: json["filterByParentId"],
        parentId: json["parentId"],
        hasFlag: json["hasFlag"],
        isDeleted: json["isDeleted"],
        sortBy: json["sortBy"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "filterByParentId": filterByParentId,
        "parentId": parentId,
        "hasFlag": hasFlag,
        "isDeleted": isDeleted,
        "sortBy": sortBy,
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => 'GetCommentRequest(referenceId: $referenceId, referenceType: $referenceType)';
}

class Options {
  Options({
    required this.type,
    required this.limit,
    required this.skip,
    required this.after,
    required this.first,
    required this.before,
    required this.last,
    required this.token,
  });

  final String type;
  final int limit;
  final int skip;
  final int after;
  final int first;
  final int before;
  final int last;
  final String token;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        type: json["type"],
        limit: json["limit"],
        skip: json["skip"],
        after: json["after"],
        first: json["first"],
        before: json["before"],
        last: json["last"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "limit": limit,
        "skip": skip,
        "after": after,
        "first": first,
        "before": before,
        "last": last,
        "token": token,
      };

  @override
  String toString() {
    return 'Options(type: $type, limit: $limit, skip: $skip, after: $after, first: $first, before: $before, last: $last, token: $token)';
  }
}
