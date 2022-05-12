import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

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
