/// ChannelUserResponse
class ChannelUserResponse {
  /// init [ChannelUserResponse]
  ChannelUserResponse({
    required this.id,
    required this.userId,
    required this.channelId,
    required this.membership,
    required this.isBanned,
    required this.lastActivity,
    required this.roles,
    required this.permissions,
    required this.readToSegment,
    required this.lastMentionedSegment,
    required this.isMuted,
    required this.muteTimeout,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Channel User Id
  final String id;

  /// User Id
  final String userId;

  /// Channel Id
  final String channelId;

  /// Membership
  final String membership;

  /// Is Banned
  final bool isBanned;

  /// Last Activity
  final DateTime lastActivity;

  /// Roles
  final List<String> roles;

  /// Permissions
  final List<String> permissions;

  /// Read to Segment
  final int readToSegment;

  /// Last Mentioned Segment
  final int lastMentionedSegment;

  /// Is Mute
  final bool isMuted;

  /// Mute Timeout
  final DateTime? muteTimeout;

  /// Create At
  final DateTime createdAt;

  /// Update At
  final DateTime updatedAt;

  factory ChannelUserResponse.fromJson(Map<String, dynamic> json) =>
      ChannelUserResponse(
        id: '${json["channelId"]}_${json["userId"]}',
        userId: json["userId"],
        channelId: json["channelId"],
        membership: json["membership"],
        isBanned: json["isBanned"],
        lastActivity: DateTime.parse(json["lastActivity"]),
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        readToSegment: json["readToSegment"],
        lastMentionedSegment: json["lastMentionedSegment"],
        isMuted: json["isMuted"],
        muteTimeout: json["muteTimeout"] == null
            ? null
            : DateTime.parse(json["muteTimeout"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "channelId": channelId,
        "membership": membership,
        "isBanned": isBanned,
        "lastActivity": lastActivity.toIso8601String(),
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "readToSegment": readToSegment,
        "lastMentionedSegment": lastMentionedSegment,
        "isMuted": isMuted,
        "muteTimeout": muteTimeout?.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
