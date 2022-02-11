// To parse this JSON data, do
//
//     final authenticationRequest = authenticationRequestFromJson(jsonString);

import 'dart:convert';

AuthenticationRequest authenticationRequestFromJson(String str) =>
    AuthenticationRequest.fromJson(json.decode(str));

String authenticationRequestToJson(AuthenticationRequest data) =>
    json.encode(data.toJson());

class AuthenticationRequest {
  AuthenticationRequest({
    required this.userId,
    this.deviceId,
    this.deviceInfo,
    this.displayName,
    this.authToken,
  });

  final String userId;
  String? deviceId;
  DeviceInfo? deviceInfo;
  String? displayName;
  String? authToken;

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) =>
      AuthenticationRequest(
        userId: json["userId"],
        deviceId: json["deviceId"],
        deviceInfo: DeviceInfo.fromJson(json["deviceInfo"]),
        displayName: json["displayName"],
        authToken: json["authToken"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "deviceId": deviceId,
        "deviceInfo": deviceInfo?.toJson() ?? null,
        "displayName": displayName,
        "authToken": authToken,
      };

  @override
  String toString() {
    return authenticationRequestToJson(this);
  }
}

class DeviceInfo {
  DeviceInfo({
    this.kind,
    this.model,
    this.sdkVersion,
  });

  String? kind;
  String? model;
  String? sdkVersion;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
        kind: json["kind"],
        model: json["model"],
        sdkVersion: json["sdkVersion"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "model": model,
        "sdkVersion": sdkVersion,
      };
}
