/// Channel Response
class ChannelResponse {
  /// init [ChannelResponse]
  ChannelResponse({
    required this.channelId,
    required this.isDistinct,
    required this.metadata,
    required this.type,
    required this.tags,
    required this.isMuted,
    required this.isRateLimited,
    required this.muteTimeout,
    required this.rateLimit,
    required this.rateLimitWindow,
    required this.rateLimitTimeout,
    required this.displayName,
    required this.messageAutoDeleteEnabled,
    required this.autoDeleteMessageByFlagLimit,
    required this.memberCount,
    required this.messageCount,
    required this.lastActivity,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarFileId,
    required this.isDeleted,
  });

  /// Channel Id
  final String channelId;

  /// Is Distinct
  final bool isDistinct;

  /// Metadata
  final Map<String, dynamic> metadata;

  ///type
  final String type;

  /// tags
  final List<String> tags;

  /// is Muted
  final bool isMuted;

  /// Is Rate Limited
  final bool isRateLimited;

  /// DateTimeOut
  final DateTime? muteTimeout;

  /// Rate Limit
  final int? rateLimit;

  /// Rate Limit Window
  final int? rateLimitWindow;

  /// Rate Limit Timeout
  final DateTime? rateLimitTimeout;

  ///Display Name
  final String? displayName;

  /// Message Auth DeleteEnable
  final bool messageAutoDeleteEnabled;

  /// Auto Delete Message By Flag Limit
  final int autoDeleteMessageByFlagLimit;

  /// Member Count
  final int memberCount;

  /// Message Count
  final int messageCount;

  /// Last Activity
  final DateTime lastActivity;

  /// Create At
  final DateTime createdAt;

  /// Update At
  final DateTime updatedAt;

  /// Avatar File id
  final String? avatarFileId;

  /// Is Deleted
  final bool isDeleted;

  /// [ChannelResponse] from  Map
  factory ChannelResponse.fromJson(Map<String, dynamic> json) =>
      ChannelResponse(
        channelId: json["channelId"],
        isDistinct: json["isDistinct"],
        metadata: json["metadata"],
        type: json["type"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        isMuted: json["isMuted"],
        isRateLimited: json["isRateLimited"],
        muteTimeout: json["muteTimeout"] == null
            ? null
            : DateTime.parse(json["muteTimeout"]),
        rateLimit: json["rateLimit"],
        rateLimitWindow: json["rateLimitWindow"],
        rateLimitTimeout: json["rateLimitTimeout"] == null
            ? null
            : DateTime.parse(json["rateLimitTimeout"]),
        displayName: json["displayName"],
        messageAutoDeleteEnabled: json["messageAutoDeleteEnabled"],
        autoDeleteMessageByFlagLimit: json["autoDeleteMessageByFlagLimit"],
        memberCount: json["memberCount"],
        messageCount: json["messageCount"],
        lastActivity: DateTime.parse(json["lastActivity"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        avatarFileId: json["avatarFileId"],
        isDeleted: json["isDeleted"],
      );

  /// [ChannelResponse] to Map
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "isDistinct": isDistinct,
        "metadata": metadata,
        "type": type,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "isMuted": isMuted,
        "isRateLimited": isRateLimited,
        "muteTimeout": muteTimeout?.toIso8601String(),
        "rateLimit": rateLimit,
        "rateLimitWindow": rateLimitWindow,
        "rateLimitTimeout": rateLimitTimeout?.toIso8601String(),
        "displayName": displayName,
        "messageAutoDeleteEnabled": messageAutoDeleteEnabled,
        "autoDeleteMessageByFlagLimit": autoDeleteMessageByFlagLimit,
        "memberCount": memberCount,
        "messageCount": messageCount,
        "lastActivity": lastActivity.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "avatarFileId": avatarFileId,
        "isDeleted": isDeleted,
      };
}
