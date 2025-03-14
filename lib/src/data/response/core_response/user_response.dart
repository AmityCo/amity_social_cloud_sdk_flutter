import 'package:amity_sdk/src/data/data.dart';

/// User model SDK receive from the BE
class UserResponse {
  /// Init the user response model
  UserResponse({
    this.id,
    this.userId,
    this.roles,
    this.permissions,
    this.displayName,
    this.description,
    this.avatarFileId,
    this.avatarCustomUrl,
    this.flagCount,
    this.hashFlag,
    this.metadata,
    this.isDeleted,
    this.isGlobalBan,
    this.createdAt,
    this.updatedAt,
    this.path,
    this.isBrand
  });

  /// DocId for user
  String? id;

  /// udid for user
  final String? userId;

  /// User roles incase of the community
  final List<String>? roles;

  /// User permission incase of the community
  final List<String>? permissions;

  /// User display name
  final String? displayName;

  /// User description (Bio)
  final String? description;

  /// User avatar file Id
  final String? avatarFileId;

  /// User Cusrom Avatar Url (Direct Avatar Url)
  final String? avatarCustomUrl;

  /// User Flag Count
  final int? flagCount;

  final HashFlag? hashFlag;

  /// User profile metadata
  final Map<String, dynamic>? metadata;

  /// Flag if user is deleted
  final bool? isDeleted;

  /// Flag if user ban globally
  final bool? isGlobalBan;

  /// User created data
  final DateTime? createdAt;

  /// User updated data
  final DateTime? updatedAt;

  /// User path with networkid
  final String? path;

  /// Flag to check if user is brand
  final bool? isBrand;

  /// Factory method to create user model from the json
  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["_id"],
        userId: json["userId"],
        roles: List<String>.from(json["roles"] ?? [].map((x) => x)),
        permissions: List<String>.from(json["permissions"] ?? [].map((x) => x)),
        displayName: json["displayName"],
        description: json["description"],
        avatarFileId: json["avatarFileId"],
        path: json["path"],
        avatarCustomUrl: json["avatarCustomUrl"],
        flagCount: json["flagCount"],
        hashFlag: json["hashFlag"] == null
            ? null
            : HashFlag.fromJson(json["hashFlag"]),
        metadata: json["metadata"],
        isDeleted: json["isDeleted"],
        isGlobalBan: json["isGlobalBan"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        isBrand: json["isBrand"]
      );

  /// Covnert the User model to map
  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions!.map((x) => x)),
        "displayName": displayName,
        "description": description,
        "avatarFileId": avatarFileId,
        "path": path,
        "avatarCustomUrl": avatarCustomUrl,
        "flagCount": flagCount,
        "hashFlag": hashFlag?.toJson(),
        "metadata": metadata,
        "isDeleted": isDeleted ?? false,
        "isGlobalBan": isGlobalBan,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isBrand": isBrand
      };
}
