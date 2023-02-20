/// [AmityMentioneeTarget]
class AmityMentioneeTarget {
  /// Target Type
  String? type;

  /// target Ids
  List<String>? userIds;

  /// init [AmityMentioneeTarget]
  AmityMentioneeTarget({this.type, this.userIds});

  factory AmityMentioneeTarget.fromJson(Map<String, dynamic> json) =>
      AmityMentioneeTarget(
        type: json["type"],
        userIds: List<String>.from(json["userIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "userIds": (userIds ?? []).toList(),
      };
}
