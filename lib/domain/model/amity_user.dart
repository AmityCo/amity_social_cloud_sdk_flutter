import 'dart:convert';

class AmityUser {
  String? id;
  String? userId;
  List<String>? roles;
  List<String>? permissions;
  String? displayName;
  String? description;
  String? avatarFileId;
  String? avatarCustomUrl;
  int? flagCount;
  //  HashFlag hashFlag;
  //  DataClass metadata;
  bool? isGlobalBan;
  DateTime? createdAt;
  DateTime? updatedAt;

  @override
  String toString() {
    return 'AmityUser(id: $id, userId: $userId, roles: $roles, permissions: $permissions, displayName: $displayName, description: $description, avatarFileId: $avatarFileId, avatarCustomUrl: $avatarCustomUrl, flagCount: $flagCount, isGlobalBan: $isGlobalBan, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'roles': roles,
      'permissions': permissions,
      'displayName': displayName,
      'description': description,
      'avatarFileId': avatarFileId,
      'avatarCustomUrl': avatarCustomUrl,
      'flagCount': flagCount,
      'isGlobalBan': isGlobalBan,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}
