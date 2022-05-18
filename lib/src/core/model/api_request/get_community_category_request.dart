// To parse this JSON data, do
//
//     final getCommunityCategoryRequest = getCommunityCategoryRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';

GetCommunityCategoryRequest getCommunityCategoryRequestFromJson(String str) =>
    GetCommunityCategoryRequest.fromJson(json.decode(str));

String getCommunityCategoryRequestToJson(GetCommunityCategoryRequest data) =>
    json.encode(data.toJson());

class GetCommunityCategoryRequest {
  GetCommunityCategoryRequest({
    required this.sortBy,
    required this.isDeleted,
    required this.options,
  });

  final String sortBy;
  final bool isDeleted;
  final OptionsRequest options;

  factory GetCommunityCategoryRequest.fromJson(Map<String, dynamic> json) =>
      GetCommunityCategoryRequest(
        sortBy: json["sortBy"],
        isDeleted: json["isDeleted"],
        options: OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "sortBy": sortBy,
        "isDeleted": isDeleted,
        "options": options.toJson(),
      };
}
