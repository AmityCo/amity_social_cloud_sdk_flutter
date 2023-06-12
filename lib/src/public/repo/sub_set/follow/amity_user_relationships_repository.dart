import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Relationship Repo to choose betweek current logged in user and explict user Id
class AmityUserRelationshipsRepository {
  /// Get follow Info for current logged in user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship() instead")
  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  /// Get follow info with user id
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship() instead")
  AmityUserRelationshipRepository user(String userId) {
    return AmityUserRelationshipRepository(userId: userId);
  }

  ///Follow this Amity User by Current logged in user
  Future<AmityFollowStatus> follow(String userId) {
    return serviceLocator<UserFollowRequestUsecase>().get(userId);
  }

  ///Unfollow this Amity User by Current logged in user
  Future<AmityFollowStatus> unfollow(String userId) {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }

  /// Accept the pending follow request
  Future<AmityFollowStatus> acceptMyFollower(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }

  /// Decline the pending follow request
  Future<AmityFollowStatus> declineMyFollower(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }

  /// Remove the user from the followers list
  Future<AmityFollowStatus> removeMyFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }

  /// Get the following user list for the user
  AmityMyFollowingsQueryBuilder getMyFollowings() {
    return AmityMyFollowingsQueryBuilder(useCase: serviceLocator());
  }

  /// Get the following user list for the user
  AmityUserFollowingsQueryBuilder getFollowings(String userId) {
    return AmityUserFollowingsQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  /// Get the Followers user list for the user
  AmityMyFollowersQueryBuilder getMyFollowers() {
    return AmityMyFollowersQueryBuilder(useCase: serviceLocator());
  }

  /// Get the Followers user list for the user
  AmityUserFollowersQueryBuilder getFollowers(String userId) {
    return AmityUserFollowersQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  ///Get Follow info for user Id
  Future<AmityMyFollowInfo> getMyFollowInfo() {
    return serviceLocator<GetMyFollowInfoUsecase>().get();
  }

  ///Get Follow info for user Id
  Future<AmityUserFollowInfo> getFollowInfo(String userId) {
    return serviceLocator<GetUserFollowInfoUsecase>().get(userId);
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
