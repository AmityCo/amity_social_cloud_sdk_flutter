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

  AmityUserRelationshipRepository relationship() {
    return AmityUserRelationshipRepository(userId: userId!);
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

  /// check if user is flagged by me
  bool get isFlaggedByMe {
    if (hashFlag == null) return false;
    return (flaggedByMe ?? false) ||
        BloomFilter(hash: (hashFlag!['hash'] as String), m: hashFlag!['bits'] as int, k: hashFlag!['hashes'] as int)
            .mightContains(AmityCoreClient.getUserId());
  }
}
