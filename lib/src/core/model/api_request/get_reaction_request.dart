// To parse this JSON data, do
//
//     final getReactionRequest = getReactionRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';

GetReactionRequest getReactionRequestFromJson(String str) =>
    GetReactionRequest.fromJson(json.decode(str));

String getReactionRequestToJson(GetReactionRequest data) =>
    json.encode(data.toJson());

class GetReactionRequest {
  GetReactionRequest({
    required this.referenceId,
    required this.referenceType,
    this.reactionName,
    this.options,
  });

  final String referenceId;
  final String referenceType;
  String? reactionName;
  OptionsRequest? options;

  factory GetReactionRequest.fromJson(Map<String, dynamic> json) =>
      GetReactionRequest(
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
        reactionName: json["reactionName"],
        options: OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "reactionName": reactionName,
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}
