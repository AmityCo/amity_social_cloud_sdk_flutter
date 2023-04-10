import 'package:amity_sdk/src/core/enum/amity_follow_status.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/relationship/amity_user_followers_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/relationship/amity_user_followings_query_builder.dart';

/// Amity Relationship Repo for userId
class AmityUserRelationshipRepository {
  /// AmityUser userId
  final String userId;

  /// Init AmityUserRelationshipRepository
  AmityUserRelationshipRepository({required this.userId});

  ///Follow this Amity User by Current logged in user
  Future<AmityFollowStatus> follow() {
    return serviceLocator<UserFollowRequestUsecase>().get(userId);
  }

  ///Unfollow this Amity User by Current logged in user
  Future<AmityFollowStatus> unfollow() {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }

  /// API to block the user
  Future block() {
    return serviceLocator<UserBlockUsecase>().get(userId);
  }

  /// API to unblock user
  Future unblock() {
    return serviceLocator<UserUnblockUsecase>().get(userId);
  }

  /// Get the following user list for the user
  AmityUserFollowingsQueryBuilder getFollowings() {
    return AmityUserFollowingsQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  /// Get the Followers user list for the user
  AmityUserFollowersQueryBuilder getFollowers() {
    return AmityUserFollowersQueryBuilder(useCase: serviceLocator(), userId: userId);
  }

  ///Get Follow info for user Id
  Future<AmityUserFollowInfo> getFollowInfo() {
    return serviceLocator<GetUserFollowInfoUsecase>().get(userId);
  }
}
