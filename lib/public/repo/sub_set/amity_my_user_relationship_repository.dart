import 'package:amity_sdk/core/service_locator/service_locator.dart';
import 'package:amity_sdk/domain/model/amity_user_follow_info.dart';
import 'package:amity_sdk/domain/usecase/relationship/accept_follow_usecase.dart';
import 'package:amity_sdk/domain/usecase/relationship/decline_follow_usecase.dart';
import 'package:amity_sdk/domain/usecase/relationship/get_my_follow_info_usecase.dart';
import 'package:amity_sdk/domain/usecase/relationship/remove_follower_usecase.dart';
import 'package:amity_sdk/domain/usecase/relationship/unfollow_usecase.dart';
import 'package:amity_sdk/public/query_builder/relationship/amity_my_followers_query_builder.dart';
import 'package:amity_sdk/public/query_builder/relationship/amity_my_followings_query_builder.dart';

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
