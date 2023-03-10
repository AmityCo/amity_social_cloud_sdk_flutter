// To parse this JSON data, do
//

class MqttPayloadResponse {
  MqttPayloadResponse({
    required this.eventType,
    required this.id,
    required this.networkId,
    required this.path,
    required this.senderId,
    required this.sentTime,
    required this.version,
    this.data,
  });

  String eventType;
  String id;
  String networkId;
  String path;
  String senderId;
  DateTime sentTime;
  int version;
  Map<String, dynamic>? data;

  MqttPayloadResponse copyWith({
    String? eventType,
    String? id,
    String? networkId,
    String? path,
    String? senderId,
    DateTime? sentTime,
    int? version,
  }) =>
      MqttPayloadResponse(
        eventType: eventType ?? this.eventType,
        id: id ?? this.id,
        networkId: networkId ?? this.networkId,
        path: path ?? this.path,
        senderId: senderId ?? this.senderId,
        sentTime: sentTime ?? this.sentTime,
        version: version ?? this.version,
      );

  factory MqttPayloadResponse.fromJson(Map<String, dynamic> json) =>
      MqttPayloadResponse(
        eventType: json["eventType"],
        id: json["id"],
        networkId: json["networkId"],
        path: json["path"],
        senderId: json["senderId"],
        sentTime: DateTime.parse(json["sentTime"]),
        version: json["version"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "eventType": eventType,
        "id": id,
        "networkId": networkId,
        "path": path,
        "senderId": senderId,
        "sentTime": sentTime.toIso8601String(),
        "version": version,
      };
}
