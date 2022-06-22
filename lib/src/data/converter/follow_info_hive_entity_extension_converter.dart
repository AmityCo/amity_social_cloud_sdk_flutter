import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension FollowInfoHiveEntityExtension on FollowInfoHiveEntity {
  AmityUserFollowInfo convertToAmityUserFollowInfo() {
    return AmityUserFollowInfo()
      ..id = userId
      ..followerCount = followerCount
      ..followingCount = followingCount
      ..status = AmityFollowStatusExtension.enumOf(status!);
  }

  AmityMyFollowInfo convertToAmityMyFollowInfo() {
    return AmityMyFollowInfo()
      ..id = userId
      ..followerCount = followerCount
      ..followingCount = followingCount
      ..pendingRequestCount = pendingCount;
  }
}
