import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

extension AccountHiveEntityExtension on AccountHiveEntity {
  AmityUser convertToAmityUser() {
    return AmityUser()
      ..id = id
      ..userId = userId
      ..displayName = displayName
      ..isGlobalBan = isActive
      ..metadata = metadata
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
