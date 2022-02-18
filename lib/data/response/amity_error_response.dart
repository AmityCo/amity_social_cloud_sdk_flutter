// To parse this JSON data, do
//
//     final amityErrorResponse = amityErrorResponseFromJson(jsonString);

import 'dart:convert';

AmityErrorResponse amityErrorResponseFromJson(String str) =>
    AmityErrorResponse.fromJson(json.decode(str));

String amityErrorResponseToJson(AmityErrorResponse data) =>
    json.encode(data.toJson());

class AmityErrorResponse {
  AmityErrorResponse({
    required this.status,
    required this.message,
    required this.code,
    this.data,
  });

  final String status;
  final String message;
  final int code;
  Data? data;

  factory AmityErrorResponse.fromJson(Map<String, dynamic> json) =>
      AmityErrorResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        // data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        // "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.detail,
  });

  final List<String>? detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        detail: json["detail"] == null
            ? null
            : List<String>.from(json["detail"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "detail":
            detail == null ? null : List<dynamic>.from(detail!.map((x) => x)),
      };
}
