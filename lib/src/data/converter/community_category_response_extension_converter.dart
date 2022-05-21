import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_category_hive_12.dart';
import 'package:amity_sdk/src/data/response/response.dart';

extension CommunityCategoryResponseExtension on CommunityCategoryResponse {
  CommunityCategoryHiveEntity convertToCommunityCategoryHiveEntity() {
    return CommunityCategoryHiveEntity()
      ..categoryId = categoryId
      ..name = name
      ..avatarFileId = avatarFileId
      ..metadata = metadata
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
