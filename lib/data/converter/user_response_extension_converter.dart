import 'package:amity_sdk/data/data_source/local/hive_entity/user_hive_entity.dart';
import 'package:amity_sdk/data/response/response.dart';

extension UserResponseExtension on UserResponse {
  UserHiveEntity convertToUserHiveEntity() {
    return UserHiveEntity()
      ..id = id
      ..userId = userId
      ..displayName = displayName
      ..description = description;
  }
}
