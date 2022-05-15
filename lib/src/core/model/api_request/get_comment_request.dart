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
  dynamic isDeleted;
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
  String toString() =>
      'GetCommentRequest(referenceId: $referenceId, referenceType: $referenceType)';
}

class Options {
  Options({
    this.type,
    this.limit,
    this.skip,
    this.after,
    this.first,
    this.before,
    this.last,
    this.token,
  });

  String? type;
  int? limit;
  int? skip;
  int? after;
  int? first;
  int? before;
  int? last;
  String? token;

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
      }..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return 'Options(type: $type, limit: $limit, skip: $skip, after: $after, first: $first, before: $before, last: $last, token: $token)';
  }
}
