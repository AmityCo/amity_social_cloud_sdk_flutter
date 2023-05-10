import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Relation Repo for Current User
class AmityMyUserRelationshipRepository {
  /* begin_public_function 
  id: user.relationship.accept_follow
  */
  /// Accept the pending follow request
  Future<AmityFollowStatus> accept(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.decline_follow
  */
  /// Decline the pending follow request
  Future<AmityFollowStatus> decline(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.follow
  */
  /// Remove the user from the followers list
  Future<AmityFollowStatus> removeFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.unfollow
  */
  /// Unfollow the user from the following list
  Future<AmityFollowStatus> unfollow(String userId) {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.query_my_followings
  */
  /// Get following user list
  AmityMyFollowingsQueryBuilder getFollowings() {
    return AmityMyFollowingsQueryBuilder(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.query_my_followers
  */
  /// Get Followers user list
  AmityMyFollowersQueryBuilder getFollowers() {
    return AmityMyFollowersQueryBuilder(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.get_my_follow_info
  */
  /// Get Follow info for the user
  Future<AmityMyFollowInfo> getFollowInfo() {
    return serviceLocator<GetMyFollowInfoUsecase>().get();
  }
  /* end_public_function */

  /// API to get blocked users
  AmityBlockUserQueryBuilder getBlockedUsers() {
    return AmityBlockUserQueryBuilder(useCase: serviceLocator());
  }

}
