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
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
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
    required this.createdAt,
  });

  final String reactionName;
  final String userId;
  final String reactionId;
  final DateTime createdAt;

  factory Reactor.fromJson(Map<String, dynamic> json) => Reactor(
        reactionName: json["reactionName"],
        userId: json["userId"],
        reactionId: json["reactionId"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "reactionName": reactionName,
        "userId": userId,
        "reactionId": reactionId,
        "createdAt": createdAt.toIso8601String(),
      };
}
