import 'package:amity_sdk/data/data_source/local/hive_entity/follow_info_hive_entity_2.dart';
import 'package:amity_sdk/data/response/follow_info_response.dart';

extension FollowInfoResponseExtension on FollowInfoResponse {
  FollowInfoHiveEntity convertToFollowInfoHiveEntity() {
    final followCount = followCounts[0];
    return FollowInfoHiveEntity()
      ..userId = followCount.userId
      ..followerCount = followCount.followerCount
      ..followingCount = followCount.followingCount
      ..pendingCount = followCount.pendingCount;
  }
}
