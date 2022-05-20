import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_category_hive_12.dart';

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
