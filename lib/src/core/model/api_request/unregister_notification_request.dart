import 'dart:convert';

UnregisterNotificationRequest unregisterNotificationRequestFromJson(
        String str) =>
    UnregisterNotificationRequest.fromJson(json.decode(str));

String unregisterNotificationRequestToJson(
        UnregisterNotificationRequest data) =>
    json.encode(data.toJson());

class UnregisterNotificationRequest {
  UnregisterNotificationRequest({required this.userId, required this.deviceId});

  final String userId;
  final String deviceId;

  factory UnregisterNotificationRequest.fromJson(Map<String, dynamic> json) =>
      UnregisterNotificationRequest(
          userId: json["userId"], deviceId: json["deviceId"]);

  Map<String, dynamic> toJson() => {"userId": userId, "deviceId": deviceId};

  @override
  String toString() {
    return unregisterNotificationRequestToJson(this);
  }
}
