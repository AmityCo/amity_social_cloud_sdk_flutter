class ReactionResponse {
  ReactionResponse({
    required this.referenceId,
    required this.referenceType,
    required this.reactors,
  });

  final String referenceId;
  final String referenceType;
  final List<Reactor> reactors;

  factory ReactionResponse.fromJson(Map<String, dynamic> json) =>
      ReactionResponse(
        referenceId: json["referenceId"]??"",
        referenceType: json["referenceType"]??"",
        reactors: List<Reactor>.from(
            json["reactors"].map((x) => Reactor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "reactors": List<dynamic>.from(reactors.map((x) => x.toJson())),
      };
}

class Reactor {
  Reactor({
    required this.reactionName,
    required this.userId,
    required this.reactionId,
    required this.eventName,
    required this.createdAt,
    this.userDisplayName,
    this.updatedAt,
  });

  final String reactionName;
  final String userId;
  final String reactionId;
  String? eventName;
  final DateTime createdAt;
  final String? userDisplayName;
  final DateTime? updatedAt;

  Reactor copyWith({
    String? reactionName,
    String? userId,
    String? reactionId,
    DateTime? createdAt,
    String? userDisplayName,
    String? eventName,
    DateTime? updatedAt,
  }) {
    return Reactor(
      reactionName: reactionName ?? this.reactionName,
      userId: userId ?? this.userId,
      reactionId: reactionId ?? this.reactionId,
      createdAt: createdAt ?? this.createdAt,
      userDisplayName: userDisplayName ?? this.userDisplayName,
      eventName: eventName ?? this.eventName,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Reactor.fromJson(Map<String, dynamic> json) => Reactor(
        reactionName: json["reactionName"],
        userId: json["userId"],
        reactionId: json["reactionId"],
        eventName: json["eventName"],
        createdAt: DateTime.parse(json["createdAt"]),
        userDisplayName: json["userDisplayName"],
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "reactionName": reactionName,
        "userId": userId,
        "reactionId": reactionId,
        "eventName": eventName,
        "createdAt": createdAt.toIso8601String(),
        "userDisplayName": userDisplayName,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
