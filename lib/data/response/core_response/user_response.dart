class UserEntity {
  UserEntity({
    required this.userId,
    required this.roles,
    required this.permissions,
    required this.displayName,
    required this.description,
    required this.avatarFileId,
    required this.avatarCustomUrl,
    required this.flagCount,
    // required this.hashFlag,
    // required this.metadata,
    required this.isGlobalBan,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final List<String> roles;
  final List<String> permissions;
  final String displayName;
  final String description;
  final String avatarFileId;
  final String avatarCustomUrl;
  final int flagCount;
  // final HashFlag hashFlag;
  // final DataClass metadata;
  final bool isGlobalBan;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userId: json["userId"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        displayName: json["displayName"],
        description: json["description"],
        avatarFileId: json["avatarFileId"],
        avatarCustomUrl: json["avatarCustomUrl"],
        flagCount: json["flagCount"],
        // hashFlag: HashFlag.fromJson(json["hashFlag"]),
        // metadata: DataClass.fromJson(json["metadata"]),
        isGlobalBan: json["isGlobalBan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "displayName": displayName,
        "description": description,
        "avatarFileId": avatarFileId,
        "avatarCustomUrl": avatarCustomUrl,
        "flagCount": flagCount,
        // "hashFlag": hashFlag.toJson(),
        // "metadata": metadata.toJson(),
        "isGlobalBan": isGlobalBan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
