import 'package:amity_sdk/src/public/repo/sub_set/follow/amity_my_user_relationship_repository.dart';
import 'package:amity_sdk/src/public/repo/sub_set/follow/amity_user_relationship_repository.dart';

/// Relationship Repo to choose betweek current logged in user and explict user Id
class AmityUserRelationshipsRepository {
  /// Get follow Info for current logged in user
  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  /// Get follow info with user id
  AmityUserRelationshipRepository user(String userId) {
    return AmityUserRelationshipRepository(userId: userId);
  }
}
