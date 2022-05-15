class FeedResponse {
  FeedResponse({
    required this.targetId,
    required this.targetType,
    required this.postCount,
    required this.feedType,
    required this.feedId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String targetId;
  final String targetType;
  final int postCount;
  final String feedType;
  final String feedId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
        targetId: json["targetId"],
        targetType: json["targetType"],
        postCount: json["postCount"],
        feedType: json["feedType"],
        feedId: json["feedId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "targetId": targetId,
        "targetType": targetType,
        "postCount": postCount,
        "feedType": feedType,
        "feedId": feedId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
