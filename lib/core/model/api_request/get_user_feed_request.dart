// To parse this JSON data, do
//
//     final userFeedRequest = userFeedRequestFromJson(jsonString);

import 'dart:convert';

import 'core/option_request.dart';

GetUserFeedRequest userFeedRequestFromJson(String str) =>
    GetUserFeedRequest.fromJson(json.decode(str));

String userFeedRequestToJson(GetUserFeedRequest data) =>
    json.encode(data.toJson());

class GetUserFeedRequest {
  GetUserFeedRequest({
    required this.userId,
    this.sortBy,
    this.isDeleted,
    this.hasFlag,
    this.options,
    this.dataTypes,
  });

  final String userId;
  String? sortBy;
  bool? isDeleted;
  bool? hasFlag;
  OptionsRequest? options;
  List<String>? dataTypes;

  factory GetUserFeedRequest.fromJson(Map<String, dynamic> json) =>
      GetUserFeedRequest(
        userId: json["userId"],
        sortBy: json["sortBy"],
        isDeleted: json["isDeleted"],
        hasFlag: json["hasFlag"],
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
        dataTypes: List<String>.from(json["dataTypes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "sortBy": sortBy,
        "isDeleted": isDeleted,
        "hasFlag": hasFlag,
        "options": options?.toJson(),
        "dataTypes": dataTypes == null
            ? null
            : List<dynamic>.from(dataTypes!.map((x) => x)),
      }..removeWhere((key, value) => value == null);
}
