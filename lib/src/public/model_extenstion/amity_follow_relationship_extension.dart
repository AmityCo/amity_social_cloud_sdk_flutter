import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension AmityFollowRelationshipExtenstion on AmityFollowRelationship {
  ///Unfollow the following user
  Future unfollow() {
    return serviceLocator<UnfollowUsecase>().get(targetUserId!);
  }

  ///Remove the user from follower list
  Future removeFollower() {
    return serviceLocator<RemoveFollowerUsecase>().get(sourceUserId!);
  }
}
