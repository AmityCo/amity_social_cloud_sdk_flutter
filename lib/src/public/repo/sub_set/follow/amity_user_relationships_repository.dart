import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/repo/sub_set/follow/amity_my_user_relationship_repository.dart';
import 'package:amity_sdk/src/public/repo/sub_set/follow/amity_user_relationship_repository.dart';

/// Relationship Repo to choose betweek current logged in user and explict user Id
class AmityUserRelationshipsRepository {
  /// Get follow Info for current logged in user
  @Deprecated("")
  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  /// Get follow info with user id
  @Deprecated("")
  AmityUserRelationshipRepository user(String userId) {
    return AmityUserRelationshipRepository(userId: userId);
  }

  /// API to block the user
  Future blockUser(String userId) {
    return serviceLocator<UserBlockUsecase>().get(userId);
  }

  /// API to unblock user
  Future unblockUser(String userId) {
    return serviceLocator<UserUnblockUsecase>().get(userId);
  }
}
