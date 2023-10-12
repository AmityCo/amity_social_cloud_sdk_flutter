import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

extension AmityUserExtenstion on AmityUser {
  UserFeedQueryBuilder getFeed() {
    return UserFeedQueryBuilder(serviceLocator(), userId!);
  }

  UserUpdateQueryBuilder update() {
    return UserUpdateQueryBuilder(serviceLocator<UpdateUserUsecase>(), userId!);
  }

  AmityMyUserRelationshipRepository me() {
    return AmityMyUserRelationshipRepository();
  }

  AmityUserRelationshipsRepository relationship() {
    return AmityUserRelationshipsRepository();
  }

  AmityUserFlagRepository report() {
    return AmityUserFlagRepository(userId: userId!);
  }

  Future blockUser() {
    return serviceLocator<UserBlockUsecase>().get(userId!);
  }

  /// API to unblock user
  Future unblockUser() {
    return serviceLocator<UserUnblockUsecase>().get(userId!);
  }

  
}
