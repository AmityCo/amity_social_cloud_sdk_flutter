import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Relation Repo for Current User
class AmityMyUserRelationshipRepository {
  /// Accept the pending follow request
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().acceptMyFollower() instead")
  Future<AmityFollowStatus> accept(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }

  /// Decline the pending follow request
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().declineMyFollower() instead")
  Future<AmityFollowStatus> decline(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }

  /// Remove the user from the followers list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().removeMyFollower() instead")
  Future<AmityFollowStatus> removeFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }

  /// Unfollow the user from the following list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().unfollow() instead")
  Future<AmityFollowStatus> unfollow(String userId) {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }

  /// Get following user list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getMyFollowings() instead")
  AmityMyFollowingsQueryBuilder getFollowings() {
    return AmityMyFollowingsQueryBuilder(useCase: serviceLocator());
  }

  /// Get Followers user list
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getMyFollowers() instead")
  AmityMyFollowersQueryBuilder getFollowers() {
    return AmityMyFollowersQueryBuilder(useCase: serviceLocator());
  }

  /// Get Follow info for the user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getMyFollowInfo() instead")
  Future<AmityMyFollowInfo> getFollowInfo() {
    return serviceLocator<GetMyFollowInfoUsecase>().get();
  }
}
