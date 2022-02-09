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
    required this.deviceId,
    required this.deviceInfo,
    required this.displayName,
    required this.authToken,
  });

  final String userId;
  final String deviceId;
  final DeviceInfo deviceInfo;
  final String displayName;
  final String authToken;

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
        "deviceInfo": deviceInfo.toJson(),
        "displayName": displayName,
        "authToken": authToken,
      };
}

class DeviceInfo {
  DeviceInfo({
    required this.kind,
    required this.model,
    required this.sdkVersion,
  });

  final String kind;
  final String model;
  final String sdkVersion;

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
