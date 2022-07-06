import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension CommunityCategoryHiveExtension on CommunityCategoryHiveEntity {
  AmityCommunityCategory convertToAmityCommunityCategory() {
    return AmityCommunityCategory()
      ..categoryId = categoryId
      ..name = name
      ..avatarId = avatarFileId
      ..metadata = metadata
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
