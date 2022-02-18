import 'package:amity_sdk/core/enum/amity_follow_status.dart';
import 'package:amity_sdk/core/service_locator/service_locator.dart';
import 'package:amity_sdk/domain/model/amity_user_follow_info.dart';
import 'package:amity_sdk/domain/usecase/relationship/get_user_follow_info_usecase.dart';
import 'package:amity_sdk/domain/usecase/relationship/user_follow_request_usecase.dart';
import 'package:amity_sdk/public/query_builder/relationship/amity_user_followers_query_builder.dart';
import 'package:amity_sdk/public/query_builder/relationship/amity_user_followings_query_builder.dart';

class AmityUserRelationshipRepository {
  final String userId;

  AmityUserRelationshipRepository({required this.userId});

  Future<AmityFollowStatus> follow() {
    return serviceLocator<UserFollowRequestUsecase>().get(userId);
  }

  AmityUserFollowingsQueryBuilder getFollowings() {
    return AmityUserFollowingsQueryBuilder(
        useCase: serviceLocator(), userId: userId);
  }

  AmityUserFollowersQueryBuilder getFollowers() {
    return AmityUserFollowersQueryBuilder(
        useCase: serviceLocator(), userId: userId);
  }

  Future<AmityUserFollowInfo> getFollowInfo() {
    return serviceLocator<GetUserFollowInfoUsecase>().get(userId);
  }
}
