import 'package:amity_sdk/src/data/data.dart';

/// [UserResponse] extension method to create [UserHiveEntity]
extension UserResponseExtension on UserResponse {
  /// Create [UserHiveEntity] object from [UserResponse] model
  UserHiveEntity convertToUserHiveEntity() {
    return UserHiveEntity()
      ..id = id
      ..userId = userId
      ..displayName = displayName
      ..description = description
      ..avatarFileId = avatarFileId
      ..avatarCustomUrl = avatarCustomUrl
      ..metadata = metadata
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..permissions = permissions
      ..roles = roles
      ..path = path
      ..isGlobalBan = isGlobalBan
      ..flagCount = flagCount
      ..hashFlag = hashFlag?.toJson();
  }
}
