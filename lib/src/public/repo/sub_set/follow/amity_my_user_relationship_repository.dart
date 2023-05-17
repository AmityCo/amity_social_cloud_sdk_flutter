import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Relation Repo for Current User
class AmityMyUserRelationshipRepository {
  /* begin_public_function 
  id: user.relationship.accept_follow
  */
  /// Accept the pending follow request
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().acceptMyFollower() instead")
  Future<AmityFollowStatus> accept(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.decline_follow
  */
  /// Decline the pending follow request
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().declineMyFollower() instead")
  Future<AmityFollowStatus> decline(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.follow
  */
  /// Remove the user from the followers list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().removeMyFollower() instead")
  Future<AmityFollowStatus> removeFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.unfollow
  */
  /// Unfollow the user from the following list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().unfollow() instead")
  Future<AmityFollowStatus> unfollow(String userId) {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.query_my_followings
  */
  /// Get following user list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getMyFollowings() instead")
  AmityMyFollowingsQueryBuilder getFollowings() {
    return AmityMyFollowingsQueryBuilder(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.query_my_followers
  */
  /// Get Followers user list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getMyFollowers() instead")
  AmityMyFollowersQueryBuilder getFollowers() {
    return AmityMyFollowersQueryBuilder(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.get_my_follow_info
  */
  /// Get Follow info for the user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getMyFollowInfo() instead")
  Future<AmityMyFollowInfo> getFollowInfo() {
    return serviceLocator<GetMyFollowInfoUsecase>().get();
  }
  /* end_public_function */
}
