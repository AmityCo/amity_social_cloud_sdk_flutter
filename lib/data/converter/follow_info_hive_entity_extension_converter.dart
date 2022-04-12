import 'package:amity_sdk/data/data_source/local/hive_entity/follow_info_hive_entity_2.dart';
import 'package:amity_sdk/domain/model/amity_user_follow_info.dart';

extension FollowInfoHiveEntityExtension on FollowInfoHiveEntity {
  AmityUserFollowInfo convertToAmityUserFollowInfo() {
    return AmityUserFollowInfo()
      ..followerCount = followerCount
      ..followingCount = followingCount;
  }
}
