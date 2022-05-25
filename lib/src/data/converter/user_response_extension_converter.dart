import 'package:amity_sdk/src/data/data.dart';

extension UserResponseExtension on UserResponse {
  UserHiveEntity convertToUserHiveEntity() {
    return UserHiveEntity()
      ..id = id
      ..userId = userId
      ..displayName = displayName
      ..description = description
      ..avatarFileId = avatarFileId
      ..metadata = metadata
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..permissions = permissions
      ..roles = roles;
  }
}
