import 'package:amity_sdk/src/domain/model/model.dart';

import '../data.dart';

extension UserHiveEntityExtension on UserHiveEntity {
  AmityUser convertToAmityUser() {
    return AmityUser()
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
