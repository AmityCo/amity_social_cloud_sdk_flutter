import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/relationship/amity_my_followers_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/relationship/amity_my_followings_query_builder.dart';

class AmityMyUserRelationshipRepository {
  /// Accept the pending follow request
  Future<void> accept(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }

  /// Decline the pending follow request
  Future<void> decline(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }

  /// Remove the user from the followers list
  Future removeFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }

  /// Unfollow the user from the following list
  Future unfollow(String userId) {
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
