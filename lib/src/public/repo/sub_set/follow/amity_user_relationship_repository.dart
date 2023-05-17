import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Relationship Repo for userId
class AmityUserRelationshipRepository {
  /// AmityUser userId
  final String userId;

  /// Init AmityUserRelationshipRepository
  AmityUserRelationshipRepository({required this.userId});

  ///Follow this Amity User by Current logged in user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().follow() instead")
  Future<AmityFollowStatus> follow() {
    return serviceLocator<UserFollowRequestUsecase>().get(userId);
  }

  ///Unfollow this Amity User by Current logged in user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().unfollow() instead")
  Future<AmityFollowStatus> unfollow() {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }

  /// Get the following user list for the user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getFollowings() instead")
  AmityUserFollowingsQueryBuilder getFollowings() {
    return AmityUserFollowingsQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  /// Get the Followers user list for the user
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getFollowers() instead")
  AmityUserFollowersQueryBuilder getFollowers() {
    return AmityUserFollowersQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  ///Get Follow info for user Id
  @Deprecated("Use AmityCoreClient.newUserRepository().relationship().getFollowInfo() instead")
  Future<AmityUserFollowInfo> getFollowInfo() {
    return serviceLocator<GetUserFollowInfoUsecase>().get(userId);
  }
}
