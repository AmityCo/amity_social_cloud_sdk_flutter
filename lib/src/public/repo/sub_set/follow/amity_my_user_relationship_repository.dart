import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Relation Repo for Current User
class AmityMyUserRelationshipRepository {
  /// Accept the pending follow request
  Future<AmityFollowStatus> accept(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }

  /// Decline the pending follow request
  Future<AmityFollowStatus> decline(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }

  /// Remove the user from the followers list
  Future<AmityFollowStatus> removeFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }

  /// Unfollow the user from the following list
  Future<AmityFollowStatus> unfollow(String userId) {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }

  /// Get following user list
  AmityMyFollowingsQueryBuilder getFollowings() {
    return AmityMyFollowingsQueryBuilder(useCase: serviceLocator());
  }

  /// Get Followers user list
  AmityMyFollowersQueryBuilder getFollowers() {
    return AmityMyFollowersQueryBuilder(useCase: serviceLocator());
  }

  /// Get Follow info for the user
  Future<AmityMyFollowInfo> getFollowInfo() {
    return serviceLocator<GetMyFollowInfoUsecase>().get();
  }
}
