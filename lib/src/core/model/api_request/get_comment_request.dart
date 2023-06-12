// To parse this JSON data, do
//
//     final getCommentRequest = getCommentRequestFromJson(jsonString);

import 'dart:convert';

String getCommentRequestToJson(GetCommentRequest data) => json.encode(data.toJson());

class GetCommentRequest {
  GetCommentRequest(
      {required this.referenceId,
      required this.referenceType,
      this.filterByParentId,
      this.parentId,
      this.hasFlag,
      this.isDeleted,
      this.sortBy,
      this.options,
      this.dataTypes,
      this.matchType});

  final String referenceId;
  final String referenceType;
  bool? filterByParentId;
  String? parentId;
  bool? hasFlag;
  dynamic isDeleted;
  String? sortBy;
  Options? options;

  List<String>? dataTypes;
  String? matchType;

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "filterByParentId": filterByParentId,
        "parentId": parentId,
        "hasFlag": hasFlag,
        "isDeleted": isDeleted,
        "sortBy": sortBy,
        "options": options?.toJson(),
        "dataTypes[values][]": dataTypes == null ? null : List<String>.from(dataTypes!.map((x) => x)),
        "dataTypes[matchType]": matchType,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => 'GetCommentRequest(referenceId: $referenceId, referenceType: $referenceType)';
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

// class DataTypes {
//   final List<String> values;
//   final String matchType;

//   DataTypes({
//     required this.values,
//     required this.matchType,
//   });

//   factory DataTypes.fromJson(Map<String, dynamic> json) => DataTypes(
//         values: List<String>.from(json["values"].map((x) => x)),
//         matchType: json["matchType"],
//       );

//   Map<String, dynamic> toJson() => {
//         "values[]": List<String>.from(values.map((x) => x)),
//         "matchType": matchType,
//       };
// }
