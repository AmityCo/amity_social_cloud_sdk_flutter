class CommunityResponse {
  CommunityResponse({
    required this.communityId,
    required this.path,
    required this.channelId,
    required this.userId,
    required this.displayName,
    required this.avatarFileId,
    required this.description,
    required this.isOfficial,
    required this.isPublic,
    required this.onlyAdminCanPost,
    required this.tags,
    required this.metadata,
    required this.postsCount,
    required this.membersCount,
    required this.isJoined,
    required this.categoryIds,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.hasFlaggedComment,
    required this.hasFlaggedPost,
    required this.needApprovalOnPostCreation,
  });

  final String communityId;
  final String path;
  final String channelId;
  final String userId;
  final String displayName;
  final String? avatarFileId;
  final String? description;
  final bool? isOfficial;
  final bool? isPublic;
  final bool? onlyAdminCanPost;
  final List<String>? tags;
  final Map<String, dynamic>? metadata;
  final int? postsCount;
  final int? membersCount;
  final bool? isJoined;
  final List<String>? categoryIds;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? hasFlaggedComment;
  final bool? hasFlaggedPost;
  final bool? needApprovalOnPostCreation;

  factory CommunityResponse.fromJson(Map<String, dynamic> json) =>
      CommunityResponse(
        communityId: json["communityId"],
        path: json["path"] ?? "",
        channelId: json["channelId"],
        userId: json["userId"],
        displayName: json["displayName"],
        avatarFileId: json["avatarFileId"],
        description: json["description"],
        isOfficial: json["isOfficial"],
        isPublic: json["isPublic"],
        onlyAdminCanPost: json["onlyAdminCanPost"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        metadata: json["metadata"],
        postsCount: json["postsCount"],
        membersCount: json["membersCount"],
        isJoined: json["isJoined"],
        categoryIds: List<String>.from(json["categoryIds"].map((x) => x)),
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        hasFlaggedComment: json["hasFlaggedComment"],
        hasFlaggedPost: json["hasFlaggedPost"],
        needApprovalOnPostCreation: json["needApprovalOnPostCreation"],
      );

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "channelId": channelId,
        "userId": userId,
        "displayName": displayName,
        "avatarFileId": avatarFileId,
        "description": description,
        "isOfficial": isOfficial,
        "isPublic": isPublic,
        "onlyAdminCanPost": onlyAdminCanPost,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "metadata": metadata,
        "postsCount": postsCount,
        "membersCount": membersCount,
        "isJoined": isJoined,
        "categoryIds": categoryIds == null
            ? null
            : List<dynamic>.from(categoryIds!.map((x) => x)),
        "isDeleted": isDeleted,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "hasFlaggedComment": hasFlaggedComment,
        "hasFlaggedPost": hasFlaggedPost,
        "needApprovalOnPostCreation": needApprovalOnPostCreation,
      };
}
