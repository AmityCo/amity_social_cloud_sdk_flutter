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

  /* begin_public_function 
  id: user.relationship.follow
  */
  ///Follow this Amity User by Current logged in user
  Future<AmityFollowStatus> follow() {
    return serviceLocator<UserFollowRequestUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.unfollow
  */
  ///Unfollow this Amity User by Current logged in user
  Future<AmityFollowStatus> unfollow() {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.query_followings
  */
  /// Get the following user list for the user
  AmityUserFollowingsQueryBuilder getFollowings() {
    return AmityUserFollowingsQueryBuilder(
        useCase: serviceLocator(), userId: userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.query_followers
  */
  /// Get the Followers user list for the user
  AmityUserFollowersQueryBuilder getFollowers() {
    return AmityUserFollowersQueryBuilder(
        useCase: serviceLocator(), userId: userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.relationship.get_follow_info
  */
  ///Get Follow info for user Id
  Future<AmityUserFollowInfo> getFollowInfo() {
    return serviceLocator<GetUserFollowInfoUsecase>().get(userId);
  }
  /* end_public_function */
}
