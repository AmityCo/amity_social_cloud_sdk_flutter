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
    this.isGlobalBan,
    this.createdAt,
    this.updatedAt,
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

  /// Flag if user ban globally
  final bool? isGlobalBan;

  /// User created data
  final DateTime? createdAt;

  /// User updated data
  final DateTime? updatedAt;

  /// Factory method to create user model from the json
  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["_id"],
        userId: json["userId"],
        roles: List<String>.from(json["roles"] ?? [].map((x) => x)),
        permissions: List<String>.from(json["permissions"] ?? [].map((x) => x)),
        displayName: json["displayName"],
        description: json["description"],
        avatarFileId: json["avatarFileId"],
        avatarCustomUrl: json["avatarCustomUrl"],
        flagCount: json["flagCount"],
        hashFlag: json["hashFlag"] == null
            ? null
            : HashFlag.fromJson(json["hashFlag"]),
        metadata: json["metadata"],
        isGlobalBan: json["isGlobalBan"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
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
        "avatarCustomUrl": avatarCustomUrl,
        "flagCount": flagCount,
        "hashFlag": hashFlag?.toJson(),
        "metadata": metadata,
        "isGlobalBan": isGlobalBan,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
