import 'dart:convert';

RegisterNotificationRequest registerNotificationRequestFromJson(String str) =>
    RegisterNotificationRequest.fromJson(json.decode(str));

String registerNotificationRequestToJson(RegisterNotificationRequest data) =>
    json.encode(data.toJson());

class RegisterNotificationRequest {
  RegisterNotificationRequest({
    required this.userId,
    required this.deviceId,
    required this.token,
    this.provider,
    required this.platform,
  });

  final String userId;
  final String deviceId;
  final String token;
  String? provider;
  final String platform;

  factory RegisterNotificationRequest.fromJson(Map<String, dynamic> json) =>
      RegisterNotificationRequest(
          userId: json["userId"],
          deviceId: json["deviceId"],
          token: json["token"],
          provider: json["provider"],
          platform: json["platform"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "deviceId": deviceId,
        "token": token,
        "provider": provider,
        "platform": platform
      };

  @override
  String toString() {
    return registerNotificationRequestToJson(this);
  }
}
