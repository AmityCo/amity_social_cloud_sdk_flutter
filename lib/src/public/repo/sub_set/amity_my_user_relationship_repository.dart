import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class AmityMyUserRelationshipRepository {
  Future<void> accept(String userId) {
    return serviceLocator<AcceptFollowUsecase>().get(userId);
  }

  Future<void> decline(String userId) {
    return serviceLocator<DeclineFollowUsecase>().get(userId);
  }

  Future removeFollower(String userId) {
    return serviceLocator<RemoveFollowerUsecase>().get(userId);
  }

  Future unfollow(String userId) {
    return serviceLocator<UnfollowUsecase>().get(userId);
  }

  AmityMyFollowingsQueryBuilder getFollowings() {
    return AmityMyFollowingsQueryBuilder(useCase: serviceLocator());
  }

  AmityMyFollowersQueryBuilder getFollowers() {
    return AmityMyFollowersQueryBuilder(useCase: serviceLocator());
  }

  Future<AmityUserFollowInfo> getFollowInfo() {
    return serviceLocator<GetMyFollowInfoUsecase>().get();
  }
}
