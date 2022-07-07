import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/model.dart';

/// [UserHiveEntity] extension method to create [AmityUser]
extension UserHiveEntityExtension on UserHiveEntity {
  /// Conver [UserHiveEntity] to public [AmityUser] modell
  AmityUser convertToAmityUser() {
    return AmityUser()
      ..id = id
      ..userId = userId
      ..displayName = displayName
      ..description = description
      ..avatarFileId = avatarFileId
      ..avatarCustomUrl = avatarCustomUrl
      ..metadata = metadata
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..roles = roles;
  }
}
