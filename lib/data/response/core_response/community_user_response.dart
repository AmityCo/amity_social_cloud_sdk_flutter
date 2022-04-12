class CommunityUserResponse {
  CommunityUserResponse({
    required this.userId,
    required this.channelId,
    required this.communityId,
    required this.communityMembership,
    required this.isBanned,
    required this.lastActivity,
    required this.roles,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final String channelId;
  final String communityId;
  final String communityMembership;
  final bool isBanned;
  final DateTime lastActivity;
  final List<String> roles;
  final List<String> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CommunityUserResponse.fromJson(Map<String, dynamic> json) =>
      CommunityUserResponse(
        userId: json["userId"],
        channelId: json["channelId"],
        communityId: json["communityId"],
        communityMembership: json["communityMembership"],
        isBanned: json["isBanned"],
        lastActivity: DateTime.parse(json["lastActivity"]),
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "channelId": channelId,
        "communityId": communityId,
        "communityMembership": communityMembership,
        "isBanned": isBanned,
        "lastActivity": lastActivity.toIso8601String(),
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
