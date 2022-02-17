import 'package:amity_sdk/data/data.dart';

extension UserResponseExtension on UserResponse {
  UserHiveEntity convertToUserHiveEntity() {
    return UserHiveEntity()
      ..id = id
      ..userId = userId
      ..displayName = displayName
      ..description = description
      ..avatarFileId = avatarFileId;
  }

  // AccountHiveEntity convertToAccountHiveEntity() {
  //   return AccountHiveEntity()
  //     ..id = id
  //     ..userId = userId
  //     ..displayName = displayName
  //     ..refreshToken = ;
  // }
}
